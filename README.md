# Dockerfile for Machine Learning

A Dockerfile for accelerated research process, consists of major machine learning libraries.

- [DockerHub](https://registry.hub.docker.com/u/uetchy/ml/)

## Features

- Ubuntu 18.04
- Python 3.6 (Miniconda 3)
- GPU accelerated (CUDA 9.0, cuDNN 7)
- NCCL, CNMeM, Apex (PyTorch only) activated
- Jupyter and OpenCV 3.0 included
- Additional packages (Tensorboard(X), Hyperdash, etc)

## Available Deep Learning Frameworks

- TensorFlow `uetchy/ml:tensorflow`
- PyTorch `uetchy/ml:pytorch`
- Chainer `uetchy/ml:chainer`
- MXnet `uetchy/ml:mxnet`
- XGBoost `uetchy/ml:xgboost`

## Install

### System Requirements

- Docker
- CUDA-enabled GPUs
- CUDA Toolkit
- nvidia-docker2 (https://github.com/NVIDIA/nvidia-docker)

### Pull the docker image from [DockerHub](https://registry.hub.docker.com/u/uetchy/ml/)

```bash
docker pull uetchy/ml:tensorflow
docker pull uetchy/ml:pytorch
docker pull uetchy/ml:chainer
...
```

### Launch Jupyter Lab on current directory

```bash
docker run --runtime=nvidia -v $PWD:/workspace -p 8888:8888 -it uetchy/ml:pytorch jupyter
open http://localhost:8888
```

### Open Python REPL

```bash
docker run --runtime=nvidia --rm -it uetchy/ml:base python
```

### Run Bash Shell

```bash
docker run --runtime=nvidia --rm -it uetchy/ml:tensorflow
```

## List of Docker images for Data Science

- [TensorFlow](https://hub.docker.com/r/tensorflow/tensorflow)
- [Caffe2](https://hub.docker.com/r/caffe2ai/caffe2)
- [MXNet](https://hub.docker.com/u/mxnet)
- [Caffe](https://github.com/BVLC/caffe/tree/master/docker)

# Contribution

PRs are accepted.

## Contributors

- Yasuaki Uechi
- UpmostScarab
- cyrusmvahid
