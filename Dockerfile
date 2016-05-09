FROM nvidia/cuda:7.5-cudnn4-runtime

MAINTAINER Yasuaki Uechi (https://randompaper.co)

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen "en_US.UTF-8" && dpkg-reconfigure locales

# Install dependencies
RUN apt-get update && apt-get install -y \
  build-essential curl wget openssl ca-certificates cmake pkg-config vim git mercurial subversion software-properties-common python-software-properties \
  libreadline-dev \
  libssl-dev \
  libbz2-dev \
  libglib2.0-0 \
  gfortran \
  imagemagick \
  libopenblas-dev \
  libatlas-dev \
  liblapack-dev \
  libhdf5-dev \
  libfreetype6-dev \
  libpng12-dev \
  libxext6 \
  libsm6 \
  libxrender1 \
  libx11-dev
RUN echo 'cacert=/etc/ssl/certs/ca-certificates.crt' > /root/.curlrc

# Install anaconda3
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    curl -Ls https://repo.continuum.io/archive/Anaconda3-4.0.0-Linux-x86_64.sh -o /usr/src/Anaconda3-4.0.0-Linux-x86_64.sh && \
    /bin/bash /usr/src/Anaconda3-4.0.0-Linux-x86_64.sh -b -p /opt/conda && \
    rm /usr/src/Anaconda3-4.0.0-Linux-x86_64.sh
ENV PATH /opt/conda/bin:$PATH
RUN conda update --all -y

# Install additional python components
RUN pip install -U \
  # Cython \
  # h5py \
  gensim

# TensorFlow
RUN git clone https://github.com/tensorflow/tensorflow.git /usr/src/tensorflow && \
  curl -Ls https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-0.8.0-cp34-cp34m-linux_x86_64.whl -o /tmp/tensorflow-0.8.0-py3-none-linux_x86_64.whl && \
  pip install /tmp/tensorflow-0.8.0-py3-none-linux_x86_64.whl && \
  rm /tmp/tensorflow-0.8.0-py3-none-linux_x86_64.whl

# Theano
RUN git clone git://github.com/Theano/Theano.git /usr/src/theano && \
  cd /usr/src/theano && \
  python setup.py install

# Torch7
RUN curl -s https://raw.githubusercontent.com/torch/ezinstall/master/install-deps | bash
RUN git clone https://github.com/torch/distro.git /usr/src/torch --recursive; cd /usr/src/torch; ./install.sh

# scikit-learn
RUN git clone https://github.com/scikit-learn/scikit-learn.git /usr/src/scikit-learn && \
  pip install scikit-learn scikit-image

# Chainer
RUN git clone https://github.com/pfnet/chainer.git /usr/src/chainer && \
  pip install chainer

# Keras
RUN git clone https://github.com/fchollet/keras.git /usr/src/keras && \
  pip install keras

# Lasagne
RUN git clone https://github.com/Lasagne/Lasagne.git /usr/src/Lasagne && \
  pip install Lasagne

# Cleanup
RUN apt-get autoremove -y

# Add runner script
COPY runner.sh /usr/src/app/runner.sh
RUN chmod +x /usr/src/app/runner.sh

WORKDIR /usr/src/app
VOLUME /usr/src/app

ENTRYPOINT ["/usr/src/app/runner.sh"]
