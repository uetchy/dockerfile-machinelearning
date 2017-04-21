FROM nvidia/cuda:8.0-cudnn5-runtime

MAINTAINER Yasuaki Uechi (https://randompaper.co)

#ENV DEBIAN_FRONTEND noninteractive
#ENV LANG C.UTF-8
ENV PATH /opt/conda/bin:$PATH

#RUN locale-gen "en_US.UTF-8" && dpkg-reconfigure locales

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential cmake curl wget openssl ca-certificates cmake pkg-config git unzip gnuplot \
  libreadline-dev libssl-dev libbz2-dev libhdf5-dev libglib2.0-0 \
  protobuf-compiler libprotobuf-dev libgoogle-glog-dev \
  gfortran imagemagick libfreetype6-dev libpng-dev libjpeg-dev \
  libopenblas-dev libatlas-dev liblapack-dev \
  libzmq3-dev libopencv-dev

#RUN echo 'cacert=/etc/ssl/certs/ca-certificates.crt' > /root/.curlrc

# Install Miniconda3
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
  curl -Ls https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/install-miniconda.sh && \
  /bin/bash /tmp/install-miniconda.sh -b -p /opt/conda && \
  conda update --all -y

# Install basic Python packages
# RUN conda install -y hdf5
RUN pip install numpy scipy cython h5py pandas matplotlib pydot_ng pillow protobuf jupyter gensim

# Install OpenCV
RUN conda install -y -c menpo opencv3 && \
  python -c 'import cv2;print(cv2.__version__)'

# Install scikit-learn
RUN pip install scikit-learn scikit-image && \
  echo -n "scikit-learn: " && python -c 'import sklearn' 2>/dev/null && echo "Success" || echo "Failure"

# Install TensorFlow
RUN git clone https://github.com/tensorflow/tensorflow.git /usr/src/tensorflow && \
  pip install tensorflow-gpu && \
  echo -n "TensorFlow: " && python -c 'import tensorflow' 2>/dev/null && echo "Success" || echo "Failure"

# Install Keras
RUN git clone https://github.com/fchollet/keras.git /usr/src/keras && \
  pip install keras

# Install PyTorch
RUN git clone https://github.com/pytorch/pytorch /usr/src/pytorch && \
  conda install -y -c soumith pytorch torchvision 

# Install Chainer
RUN git clone https://github.com/pfnet/chainer.git /usr/src/chainer && \
  pip install chainer

# Install Caffe2
# RUN git clone --recursive https://github.com/caffe2/caffe2.git /usr/src/caffe2 && \
#   cd /usr/src/caffe2 && \
#   make && cd build && make install && \
#   python -c 'from caffe2.python import core' 2>/dev/null && echo "Success" || echo "Failure" && \
#   python -m caffe2.python.operator_test.relu_op_test

# Install MXNet
# RUN git clone --recursive https://github.com/dmlc/mxnet /usr/src/mxnet && \
#   cd /usr/src/mxnet && \
#   cp make/config.mk . && \
#   echo "USE_BLAS=openblas" >> config.mk && \
#   make -j$(nproc)

# Install torch
# RUN git clone https://github.com/torch/distro.git /usr/src/torch --recursive && \
#   cd /usr/src/torch && \
#   ./install.sh

# Add runner script
COPY runner.sh /usr/src/app/runner.sh
RUN chmod +x /usr/src/app/runner.sh

WORKDIR /usr/src/app
VOLUME /usr/src/app

ENTRYPOINT ["/usr/src/app/runner.sh"]