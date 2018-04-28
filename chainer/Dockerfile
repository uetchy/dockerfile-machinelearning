FROM nvidia/cuda:9.0-cudnn7-devel

ENV DEBIAN_FRONTEND noninteractive
ENV CUDA_HOME /usr/local/cuda
# ENV LANG C.UTF-8
# RUN locale-gen "en_US.UTF-8" && dpkg-reconfigure locales

# System dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    curl \
    git \
    graphviz \
    imagemagick \
    pkg-config \
    unzip \
    vim \
    wget \
    > /dev/null

# CNMeM
RUN git clone --depth 1 https://github.com/NVIDIA/cnmem.git /usr/src/cnmem && \
    mkdir /usr/src/cnmem/build && \
    cd /usr/src/cnmem/build && \
    cmake .. && \
    make -j install

# NCCL
RUN git clone --depth 1 https://github.com/NVIDIA/nccl.git /usr/src/nccl && \
    cd /usr/src/nccl && \
    make -j install

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
    hdf5 \
    mkl \
    openblas \
    protobuf \
    readline
RUN pip install -U \
    cython \
    h5py \
    hyperdash \
    jupyterlab \
    matplotlib \
    nnpack \
    numpy \
    pandas \
    pillow \
    pip \
    pydot_ng \
    scikit-image \
    scikit-learn \
    scipy

# OpenCV
RUN conda install opencv3 -c menpo -y

# Chainer
RUN git clone --depth 1 https://github.com/pfnet/chainer.git /usr/src/chainer && \
    pip install -U chainer cupy-cuda90

COPY runner.sh /usr/src/app/runner.sh
RUN chmod +x /usr/src/app/runner.sh

WORKDIR /usr/src/app
VOLUME /usr/src/app

ENTRYPOINT ["/usr/src/app/runner.sh"]
