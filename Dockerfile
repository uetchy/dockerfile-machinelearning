FROM nvidia/cuda:7.5-cudnn4-runtime

MAINTAINER Yasuaki Uechi (https://randompaper.co)

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN locale-gen "en_US.UTF-8" && dpkg-reconfigure locales

# Install dependencies
RUN apt-get update && apt-get install -y \
  build-essential gcc g++ curl wget openssl ca-certificates cmake pkg-config git python-software-properties \
  libreadline-dev \
  libssl-dev \
  libbz2-dev libhdf5-dev \
  libglib2.0-0 \
  gfortran \
  imagemagick libfreetype6-dev libpng-dev libjpeg-dev \
  libopenblas-dev libatlas-dev liblapack-dev \
  libxext6 \
  libsm6 \
  libx11-dev libxrender1 \
  ncurses-dev \
  libqt4-core libqt4-dev \
  libzmq3-dev unzip gnuplot \
  git \
  libopenblas-dev \
  libopencv-dev \
  python-numpy \
  wget \
  unzip

RUN echo 'cacert=/etc/ssl/certs/ca-certificates.crt' > /root/.curlrc

# Install anaconda3

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    curl -Ls https://repo.continuum.io/archive/Anaconda3-4.0.0-Linux-x86_64.sh -o /tmp/Anaconda3-4.0.0-Linux-x86_64.sh && \
    /bin/bash /tmp/Anaconda3-4.0.0-Linux-x86_64.sh -b -p /opt/conda && \
    conda update --all -y

# Install additional python components
RUN pip install -U gensim

# Clone repositories
RUN git clone https://github.com/tensorflow/tensorflow.git /usr/src/tensorflow && \
  git clone git://github.com/Theano/Theano.git /usr/src/theano && \
  git clone https://github.com/torch/distro.git /usr/src/torch --recursive && \
  git clone https://github.com/scikit-learn/scikit-learn.git /usr/src/scikit-learn && \
  git clone https://github.com/pfnet/chainer.git /usr/src/chainer && \
  git clone https://github.com/fchollet/keras.git /usr/src/keras && \
  git clone https://github.com/Lasagne/Lasagne.git /usr/src/Lasagne && \
  git clone --recursive https://github.com/dmlc/mxnet/ && cd mxnet && \
    cp make/config.mk . && \
    echo "USE_BLAS=openblas" >>config.mk && \
    make -j$(nproc)

# TensorFlow
RUN curl -Ls https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-0.8.0-cp34-cp34m-linux_x86_64.whl -o /tmp/tensorflow-0.8.0-py3-none-linux_x86_64.whl && \
  pip install /tmp/tensorflow-0.8.0-py3-none-linux_x86_64.whl && \
  cd /usr/src/theano && python setup.py install && \
  cd /usr/src/torch; ./install.sh && \
  pip install scikit-learn scikit-image chainer keras Lasagne numpy pandas matplotlib


ENV PYTHONPATH /mxnet/python

# Add runner script
COPY runner.sh /usr/src/app/runner.sh
RUN chmod +x /usr/src/app/runner.sh

WORKDIR /usr/src/app
VOLUME /usr/src/app

ENTRYPOINT ["/usr/src/app/runner.sh"]
