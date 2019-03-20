FROM nvidia/cuda:10.0-cudnn7-devel

ENV DEBIAN_FRONTEND noninteractive
ENV CUDA_HOME /usr/local/cuda

# System dependencies
RUN apt-get update && apt-get install --no-install-recommends -y \
  build-essential \
  curl \
  wget \
  git \
  cmake \
  vim \
  pkg-config \
  unzip \
  libgtk2.0-dev \
  imagemagick \
  graphviz
# libgtk2.0-dev is for OpenCV

RUN ldconfig

# Miniconda 3
ENV PATH /opt/conda/bin:$PATH
ENV LB_LIBRARY_PATH /opt/conda/lib:$LB_LIBRARY_PATH
RUN curl -Ls https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/install-miniconda.sh && \
  /bin/bash /tmp/install-miniconda.sh -b -p /opt/conda && \
  conda update -n base conda && \
  conda update --all -y

# CNMeM - A simple memory manager for CUDA designed to help Deep Learning frameworks manage memory
RUN git clone --depth 1 https://github.com/NVIDIA/cnmem.git /usr/src/cnmem && \
  mkdir /usr/src/cnmem/build && cd /usr/src/cnmem/build && \
  cmake .. && make -j install

# NCCL - Optimized primitives for collective multi-GPU communication
RUN git clone --depth 1 https://github.com/NVIDIA/nccl.git /usr/src/nccl && \
  cd /usr/src/nccl && make -j install

# Basic dependencies
RUN conda install -y \
  boost \
  cython \
  gensim \
  hdf5 \
  jupyterlab \
  leveldb \
  lmdb \
  matplotlib \
  mkl \
  numpy \
  openblas \
  pandas \
  pillow \
  protobuf \
  readline \
  scipy

RUN pip install \
  h5py \
  hyperdash \
  nnpack \
  pydot_ng \
  scikit-image \
  scikit-learn

# OpenCV
RUN conda install opencv3 -c menpo -y

WORKDIR /workspace
VOLUME /workspace

RUN ln -s /usr/src /root/src && ln -s /project /root/project