FROM nvidia/cuda:8.0-cudnn5-devel

MAINTAINER Yasuaki Uechi (https://randompaper.co)

ENV DEBIAN_FRONTEND noninteractive
ENV CUDA_HOME /usr/local/cuda
#ENV LANG C.UTF-8
#RUN locale-gen "en_US.UTF-8" && dpkg-reconfigure locales

# System dependencies
RUN apt-get update
RUN apt-get install -y \
    build-essential curl wget git cmake pkg-config unzip imagemagick libgtk2.0-dev > /dev/null
# libgtk2.0-dev -> OpenCV

# Miniconda3
ENV PATH /opt/conda/bin:$PATH
ENV LB_LIBRARY_PATH /opt/conda/lib:$LB_LIBRARY_PATH
RUN curl -Ls https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/install-miniconda.sh && \
    /bin/bash /tmp/install-miniconda.sh -b -p /opt/conda && \
    conda update --all -y

# Basic dependencies
RUN conda install -y bzip2 glib readline mkl openblas numpy scipy hdf5 \
    pillow matplotlib cython pandas gensim protobuf \
    lmdb leveldb boost glog gflags
RUN pip install pydot_ng nnpack h5py scikit-learn scikit-image && \
    python -c 'import h5py;h5py.run_tests()'

# OpenCV
RUN conda install -y -c menpo opencv3 && \
    python -c "import cv2;print(cv2.__version__)"

# CNMeM
RUN git clone --depth 1 https://github.com/NVIDIA/cnmem.git /usr/src/cnmem && \
    mkdir /usr/src/cnmem/build && cd /usr/src/cnmem/build && cmake .. && make -j install

# NCCL
RUN git clone --depth 1 https://github.com/NVIDIA/nccl.git /usr/src/nccl && \
    cd /usr/src/nccl && make -j install

RUN ldconfig

# Jupyter
RUN pip install -q jupyter jupyterlab && \
    jupyter --version

# TensorFlow
RUN git clone --depth 1 https://github.com/tensorflow/tensorflow.git /usr/src/tensorflow && \
    pip install -q tensorflow-gpu
# cannot use GPUs within build process, you can also do GPU test manually:
#   python -c 'import tensorflow as tf;sess = tf.Session(config=tf.ConfigProto(log_device_placement=True))'

# Keras
RUN git clone --depth 1 https://github.com/fchollet/keras.git /usr/src/keras && \
    pip install keras

# PyTorch
RUN git clone --depth 1 https://github.com/pytorch/tutorials.git /usr/src/pytorch-tutorials && \
    conda install -y -c soumith pytorch torchvision 
# this works only in python3.5 for now
#   conda create -n py35 python=3.5
#   conda activate py35

# Chainer
RUN git clone --depth 1 https://github.com/pfnet/chainer.git /usr/src/chainer && \
    pip install chainer

# Caffe
RUN git clone --depth 1 https://github.com/BVLC/caffe.git /usr/src/caffe && \
    mkdir /usr/src/caffe/build && cd /usr/src/caffe/build && \
    cmake -DUSE_CUDNN=1 \
          -DUSE_NCCL=1 \
          -DBLAS=open .. && \
    make -j all

# Caffe2
RUN apt-get install -y protobuf-compiler libprotobuf-dev libgoogle-glog-dev && \
    git clone --recursive  --depth 1 https://github.com/caffe2/caffe2.git /usr/src/caffe2 && \
    cd /usr/src/caffe2 && \
    make && cd build && make install && \
    python -c 'from caffe2.python import core' 2>/dev/null && echo "Success" || echo "Failure" && \
    python -m caffe2.python.operator_test.relu_op_test

# Torch
RUN git clone --recursive  --depth 1 https://github.com/torch/distro.git /usr/src/torch && \
    cd /usr/src/torch && \
    ./install.sh

# MXNet
# RUN git clone --recursive https://github.com/dmlc/mxnet /usr/src/mxnet && \
#     cd /usr/src/mxnet && \
#     cp make/config.mk . && \
#     echo "USE_BLAS=openblas" >> config.mk && \
#     make -j$(nproc)

COPY runner.sh /usr/src/app/runner.sh

WORKDIR /usr/src/app
VOLUME /usr/src/app

ENTRYPOINT ["/usr/src/app/runner.sh"]
