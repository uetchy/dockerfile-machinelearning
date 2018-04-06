# dockerfile-machinelearning

A Dockerfile consist of major machine learning libraries, for students and researchers.

## Spec

* Ubuntu 16.04
* Python 3.6 with Miniconda3
* GPU accelerated (CUDA 9.0, cuDNN 7)

### General packages

* numpy
* scipy
* scikit-learn
* Jupyter
* OpenCV 3
* ImageMagick
* ...

### Deep learning packages

* TensorFlow
* Keras
* Chainer
* PyTorch
* MXnet
* Caffe2 (optional)
* Caffe (optional)
* Torch7 (optional)

Optional packages can be installed by modifying and rebuilding Dockerfile.

## Install

### System Requirements

* Docker
* CUDA-enabled GPUs
* CUDA Toolkit
* nvidia-docker (https://github.com/NVIDIA/nvidia-docker)

### Pull the docker image from [DockerHub](https://registry.hub.docker.com/u/uetchy/machinelearning/)

```
docker pull uetchy/machinelearning
```

### Launch Jupyter Notebook on current directory

```
docker run --runtime=nvidia -v $PWD:/app -p 8888:8888 -it uetchy/machinelearning jupyter
open http://localhost:8888
```

`default` is a Docker Machine name. you would replace with whatever you want.

> Docker Remote API users beware: Volume mounting is not available which is connected from Remote API

### Run Python REPL

```
docker run --runtime=nvidia --rm -it uetchy/machinelearning python
```

### Run shell

```
docker run --runtime=nvidia --rm -it uetchy/machinelearning
```

### Reach entire source codes

```
docker run --runtime=nvidia --rm -it uetchy/machinelearning
cd /usr/src
ls
```

## Alternative Docker images

* [Caffe](https://github.com/BVLC/caffe/tree/master/docker)
* [Caffe2](https://caffe2.ai/docs/getting-started.html?platform=ubuntu&configuration=docker)
* [TensorFlow](https://github.com/tensorflow/tensorflow/blob/master/tensorflow/tools/docker/README.md)
