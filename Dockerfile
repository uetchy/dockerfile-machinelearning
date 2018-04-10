FROM nvidia/cuda:9.0-cudnn7-devel

ENV DEBIAN_FRONTEND noninteractive
ENV CUDA_HOME /usr/local/cuda
# ENV LANG C.UTF-8
# RUN locale-gen "en_US.UTF-8" && dpkg-reconfigure locales

# System dependencies
RUN apt-get update
RUN apt-get install -y \
    build-essential curl wget git cmake vim pkg-config unzip libgtk2.0-dev \
    imagemagick graphviz > /dev/null
# libgtk2.0-dev -> OpenCV

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
RUN conda install -y readline mkl openblas numpy scipy hdf5 \
    pillow matplotlib cython pandas gensim protobuf \
    lmdb leveldb boost jupyterlab
RUN pip install pydot_ng nnpack h5py scikit-learn scikit-image hyperdash

# OpenCV
RUN conda install opencv3 -c menpo -y

# TensorFlow
## install Bazel
RUN apt-get install openjdk-8-jdk -y && \
    echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" >> /etc/apt/sources.list.d/bazel.list && \
    curl https://bazel.build/bazel-release.pub.gpg | apt-key add - && \
    apt-get update && \
    apt-get install bazel -y
# see https://gist.github.com/PatWie/0c915d5be59a518f934392219ca65c3d
# and https://github.com/tensorflow/tensorflow/blob/master/configure.py
# and https://github.com/tensorflow/tensorflow/blob/master/tools/bazel.rc
# for noninteractive tf build
RUN git clone --depth 1 -b r1.7 https://github.com/tensorflow/tensorflow.git /usr/src/tensorflow && \
    cd /usr/src/tensorflow && \
    PYTHON_BIN_PATH=$(which python) \
    PYTHON_LIB_PATH="$($PYTHON_BIN_PATH -c 'import site; print(site.getsitepackages()[0])')" \
    CUDA_TOOLKIT_PATH=/usr/local/cuda \
    CUDNN_INSTALL_PATH=/usr \
    TF_NEED_GCP=0 \
    TF_NEED_CUDA=1 \
    TF_CUDA_VERSION="$($CUDA_TOOLKIT_PATH/bin/nvcc --version | sed -n 's/^.*release \(.*\),.*/\1/p')" \
    TF_CUDA_COMPUTE_CAPABILITIES=6.1,5.2,3.5 \
    TF_NEED_HDFS=0 \
    TF_NEED_OPENCL=0 \
    TF_NEED_JEMALLOC=1 \
    TF_ENABLE_XLA=0 \
    TF_NEED_VERBS=0 \
    TF_CUDA_CLANG=0 \
    TF_CUDNN_VERSION="$(sed -n 's/^#define CUDNN_MAJOR\s*\(.*\).*/\1/p' $CUDNN_INSTALL_PATH/include/cudnn.h)" \
    TF_NEED_MKL=0 \
    TF_DOWNLOAD_MKL=0 \
    TF_NEED_MPI=0 \
    TF_NEED_OPENCL_SYCL=0 \
    TF_NEED_S3=0 \
    TF_NEED_KAFKA=0 \
    TF_NEED_TENSORRT=0 \
    TF_NEED_GDR=0 \
    TF_SET_ANDROID_WORKSPACE=0 \
    GCC_HOST_COMPILER_PATH=$(which gcc) \
    CC_OPT_FLAGS="-march=native" ./configure && \
    bazel build --config=opt --config=cuda //tensorflow/tools/pip_package:build_pip_package && \
    bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg && \
    pip install /tmp/tensorflow_pkg/tensorflow-1.7.0-cp36-cp36m-linux_x86_64.whl
# cannot use GPUs within build process, you can also do GPU test manually:
# python -c 'import tensorflow as tf;sess = tf.Session(config=tf.ConfigProto(log_device_placement=True))'

# Keras
RUN git clone --depth 1 https://github.com/fchollet/keras.git /usr/src/keras && \
    pip install keras

# Chainer
RUN git clone --depth 1 https://github.com/pfnet/chainer.git /usr/src/chainer && \
    pip install chainer cupy

# PyTorch
RUN git clone --depth 1 https://github.com/pytorch/tutorials.git /usr/src/pytorch-tutorials && \
    conda config --prepend channels pytorch && \
    conda install pytorch torchvision cuda90 -y

# MXNet
RUN git clone --depth 1 --recursive https://github.com/dmlc/mxnet /usr/src/mxnet && \
    pip install mxnet-cu90

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

# XGBoost
RUN git clone --depth 1 --recursive https://github.com/dmlc/xgboost /usr/src/xgboost && \
    mkdir /usr/src/xgboost/build && cd /usr/src/xgboost/build && \
    cmake .. -DUSE_CUDA=ON && \
    make -j4 && \
    cd ../python-package && python setup.py install

COPY runner.sh /usr/src/app/runner.sh
RUN chmod +x /usr/src/app/runner.sh

WORKDIR /usr/src/app
VOLUME /usr/src/app

ENTRYPOINT ["/usr/src/app/runner.sh"]
