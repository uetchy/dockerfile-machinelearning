# dockerfile-machinelearning

A Dockerfile for accelerated research process, consists of major machine learning libraries.

- [DockerHub](https://registry.hub.docker.com/u/uetchy/machinelearning/)

## Features

- Ubuntu 18.04
- Python 3.6 (Miniconda3)
- GPU accelerated (CUDA 10.0, cuDNN 7)
- Jupyter Lab enabled
- OpenCV 3.0 included
- Hyperdash

## Available Deep Learning Frameworks

- PyTorch `uetchy/machinelearning:pytorch`
- TensorFlow `uetchy/machinelearning:tensorflow`
- Chainer `uetchy/machinelearning:chainer`
- MXnet `uetchy/machinelearning:mxnet`
- XGBoost `uetchy/machinelearning:xgboost`

## Install

### System Requirements

- Docker
- CUDA-enabled GPUs
- CUDA Toolkit
- nvidia-docker2 (https://github.com/NVIDIA/nvidia-docker)

### Pull the docker image from [DockerHub](https://registry.hub.docker.com/u/uetchy/machinelearning/)

```bash
docker pull uetchy/machinelearning:tensorflow
docker pull uetchy/machinelearning:pytorch
docker pull uetchy/machinelearning:chainer
...
```

### Launch Jupyter Lab on current directory

```bash
docker run --runtime=nvidia -v $PWD:/app -p 8888:8888 -it uetchy/machinelearning:pytorch jupyter
open http://localhost:8888
```

### Open Python REPL

```bash
docker run --runtime=nvidia --rm -it uetchy/machinelearning:base python
```

### Run Bash Shell

```bash
docker run --runtime=nvidia --rm -it uetchy/machinelearning:tensorflow
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
