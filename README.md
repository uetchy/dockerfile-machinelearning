# dockerfile-machinelearning

Dockerfile for studying/analyzing with Machine Learning.

## Features

- Python3.5.1 on Anaconda3
- NVIDIA GPU support (CUDA 7.5 + cuDNN 4)

### General

- Jupyter Notebook
- numpy
- scipy
- matplotlib
- nltk
- gensim

### Machine Learning

- TensorFlow
- Theano
- Keras
- Lasagne
- Chainer
- Torch7
- scikit-learn

## Usage

### Pull docker image from [DockerHub](https://registry.hub.docker.com/u/uetchy/machinelearning/)

```
$ docker pull uetchy/machinelearning
```

### Launch Jupyter Notebook on current directory

```
$ docker run -v $PWD:/app -p 80:8888 -it uetchy/machinelearning jupyter
$ open http://$(docker-machine ip default)
```

`default` is a Docker Machine name. you would replace with whatever you want.

> Docker Remote API users beware: Volume mounting is not available for Docker connected from Remote API

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

- [Caffe](https://github.com/tleyden/docker/tree/master/caffe)
- [TensorFlow](https://github.com/tensorflow/tensorflow/blob/master/tensorflow/g3doc/get_started/os_setup.md#docker-installation)
