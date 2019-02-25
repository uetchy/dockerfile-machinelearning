FROM nvidia/cuda:10.0-cudnn7-devel

ENV DEBIAN_FRONTEND noninteractive
ENV CUDA_HOME /usr/local/cuda
# ENV LANG C.UTF-8
# RUN locale-gen "en_US.UTF-8" && dpkg-reconfigure locales

# System dependencies
RUN apt-get update && apt-get install -y \
  build-essential curl \
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

# Miniconda3
ENV PATH /opt/conda/bin:$PATH
ENV LB_LIBRARY_PATH /opt/conda/lib:$LB_LIBRARY_PATH
RUN curl -Ls https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/install-miniconda.sh && \
  /bin/bash /tmp/install-miniconda.sh -b -p /opt/conda && \
  conda update -n base conda && \
  conda update --all -y

# Basic dependencies
RUN conda install -y \
  readline \
  cython \
  mkl \
  openblas \
  boost \
  hdf5 \
  lmdb \
  leveldb \
  protobuf \
  matplotlib \
  pillow \
  numpy \
  scipy \
  pandas \
  gensim \
  jupyterlab
RUN pip install \
  pydot_ng \
  nnpack \
  h5py \
  scikit-learn \
  scikit-image \
  hyperdash

# CNMeM
RUN git clone --depth 1 https://github.com/NVIDIA/cnmem.git /usr/src/cnmem && \
  mkdir /usr/src/cnmem/build && cd /usr/src/cnmem/build && \
  cmake .. && make -j install

# NCCL
RUN git clone --depth 1 https://github.com/NVIDIA/nccl.git /usr/src/nccl && \
  cd /usr/src/nccl && make -j install

# Apex
RUN git clone --depth 1 https://github.com/NVIDIA/apex.git /usr/src/apex && \
  cd /usr/src/apex && python setup.py install --cuda_ext --cpp_ext

# OpenCV
RUN conda install opencv3 -c menpo -y

WORKDIR /project
VOLUME /project