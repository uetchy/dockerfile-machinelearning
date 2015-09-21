# dockerfile-machinelearning

Dockerfile for studying/analyzing with Machine Learning.

## Available packages

- Python 3.4.0 with miniconda3 on pyenv
- IPython Notebook
- numpy, scipy, matplotlib, nltk, gensim
- scikit-learn, Theano, Pylearn2, chainer
- [Caffe](https://registry.hub.docker.com/u/tleyden5iwx/caffe-cpu-master/)

## Usage

### Pull image from [DockerHub](https://registry.hub.docker.com/u/uetchy/machinelearning/)

```
$ docker pull uetchy/machinelearning
```

### Launch Jupyter Notebook on current directory

```
$ docker run -v $(pwd):/workdir -p 80:8888 -it uetchy/machinelearning jupyter
$ open http://$(docker-machine ip <your machine name>)
```

> Docker Remote API users beware:
>   Volume mounting is not available on Docker connected by Remote API

### Run python REPL

```
$ docker run -it uetchy/machinelearning jupyter
```
