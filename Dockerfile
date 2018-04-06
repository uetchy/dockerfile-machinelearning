FROM nvidia/cuda:9.0-cudnn7-devel

ENV DEBIAN_FRONTEND noninteractive
ENV CUDA_HOME /usr/local/cuda
# ENV LANG C.UTF-8
# RUN locale-gen "en_US.UTF-8" && dpkg-reconfigure locales

# System dependencies
RUN apt-get update
RUN apt-get install -y \
    build-essential curl wget git cmake pkg-config unzip libgtk2.0-dev \
    imagemagick graphviz > /dev/null
# libgtk2.0-dev -> OpenCV

# CNMeM
RUN git clone --depth 1 https://github.com/NVIDIA/cnmem.git /usr/src/cnmem && \
    mkdir /usr/src/cnmem/build && cd /usr/src/cnmem/build && cmake .. && make -j install

# NCCL
RUN git clone --depth 1 https://github.com/NVIDIA/nccl.git /usr/src/nccl && \
    cd /usr/src/nccl && make -j install

RUN ldconfig

# Miniconda3
ENV PATH /opt/conda/bin:$PATH
ENV LB_LIBRARY_PATH /opt/conda/lib:$LB_LIBRARY_PATH
RUN curl -Ls https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/install-miniconda.sh && \
    /bin/bash /tmp/install-miniconda.sh -b -p /opt/conda && \
    conda update -n base conda && \
    conda config --append channels conda-forge && \
    conda update --all -y

# Basic dependencies
RUN conda install -y bzip2 glib readline mkl openblas numpy scipy hdf5 \
    pillow matplotlib cython pandas gensim protobuf \
    lmdb leveldb boost glog gflags jupyter jupyterlab
RUN pip install pydot_ng nnpack h5py scikit-learn scikit-image

# OpenCV
RUN conda install opencv3 -c menpo -y

# TensorFlow
RUN git clone --depth 1 https://github.com/tensorflow/tensorflow.git /usr/src/tensorflow && \
    pip install tensorflow-gpu
# cannot use GPUs within build process, you can also do GPU test manually:
#   python -c 'import tensorflow as tf;sess = tf.Session(config=tf.ConfigProto(log_device_placement=True))'

# Keras
RUN git clone --depth 1 https://github.com/fchollet/keras.git /usr/src/keras && \
    pip install keras

# Chainer
RUN git clone --depth 1 https://github.com/pfnet/chainer.git /usr/src/chainer && \
    install chainer cupy

# PyTorch
RUN git clone --depth 1 https://github.com/pytorch/tutorials.git /usr/src/pytorch-tutorials && \
    conda config --prepend channels pytorch && \
    conda install pytorch torchvision cuda90 -y

# MXNet
RUN git clone --depth 1 --recursive https://github.com/dmlc/mxnet /usr/src/mxnet && \
    conda install mxnet-cu90

# Caffe2
# RUN git clone --depth 1 --recursive https://github.com/caffe2/caffe2.git /usr/src/caffe2 && \
#     conda install caffe2-cuda9.0-cudnn7-gcc4.8 -c caffe2

# Torch
# RUN git clone --depth 1 --recursive https://github.com/torch/distro.git /usr/src/torch && \
#     cd /usr/src/torch && \
#     ./install.sh

# Caffe
# RUN git clone --depth 1 https://github.com/BVLC/caffe.git /usr/src/caffe && \
#     mkdir /usr/src/caffe/build && cd /usr/src/caffe/build && \
#     cmake -DUSE_CUDNN=1 \
#     -DUSE_NCCL=1 \
#     -DBLAS=open .. && \
#     make -j all

COPY runner.sh /usr/src/app/runner.sh

WORKDIR /usr/src/app
VOLUME /usr/src/app

ENTRYPOINT ["/usr/src/app/runner.sh"]