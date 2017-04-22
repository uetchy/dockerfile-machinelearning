# dockerfile-machinelearning

A Dockerfile consist of major machine learning libraries, for students and researchers.

## Features

- Ubuntu 16.04
- Python 3.6 on Miniconda3
- GPU accelerated (CUDA 8.0 + cuDNN 5)

### General

- numpy, scipy, scikit-learn, ...
- Jupyter
- HDF5
- OpenCV 3
- ImageMagick
- ...

### Deep Learning

- TensorFlow
- Theano
- Keras
- PyTorch
- Chainer
- Torch7
- Caffe
- Caffe2

## Install

### System Requirements

- Docker
- CUDA-enabled GPUs
- CUDA Toolkit
- nvidia-docker

### Pull the docker image from [DockerHub](https://registry.hub.docker.com/u/uetchy/machinelearning/)

```
$ docker pull uetchy/machinelearning
```

### Launch Jupyter Notebook on current directory

```
$ docker run -v $PWD:/app -p 80:8888 -it uetchy/machinelearning jupyter
$ open http://$(docker-machine ip default)
```

`default` is a Docker Machine name. you would replace with whatever you want.

> Docker Remote API users beware: Volume mounting is not available which is connected from Remote API

### Run Python REPL

```
$ docker run -it uetchy/machinelearning python
```

### Run shell

```
$ docker run -it uetchy/machinelearning
```

### Reach entire source codes

```
$ cd /usr/src
$ ls
```

## Alternative Docker images

- [Caffe](https://github.com/BVLC/caffe/tree/master/docker)
- [Caffe2](https://caffe2.ai/docs/getting-started.html?platform=ubuntu&configuration=docker)
- [TensorFlow](https://github.com/tensorflow/tensorflow/blob/master/tensorflow/tools/docker/README.md)