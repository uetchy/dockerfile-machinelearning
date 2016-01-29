# dockerfile-machinelearning
Dockerfile for studying/analyzing with Machine Learning.

## Available packages
Python 3.4.x with pyenv

### General
- Jupyter Notebook
- numpy
- scipy
- matplotlib
- nltk
- gensim

### Machine Learning
- scikit-learn
- Chainer
- TensorFlow
- Theano
- Keras
- Lasagne

## Usage
### Pull image from [DockerHub](https://registry.hub.docker.com/u/uetchy/machinelearning/)

```
$ docker pull uetchy/machinelearning
```

### Launch Jupyter Notebook on current directory

```
$ docker run -v $PWD:/app -p 80:8888 -it uetchy/machinelearning jupyter
$ open http://$(docker-machine ip default)
```

`default` is a Docker Machine name. you would replace with whatever you want.

> Docker Remote API users beware:   Volume mounting is not available for Docker connected from Remote API

### Run python REPL

```
$ docker run -it uetchy/machinelearning python
```

## Docker-ready alternatives
- [Caffe](https://github.com/tleyden/docker/tree/master/caffe)
- [TensorFlow](https://github.com/tensorflow/tensorflow/blob/master/tensorflow/g3doc/get_started/os_setup.md#docker-installation)
