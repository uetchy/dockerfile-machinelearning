# dockerfile-machinelearning

Dockerfile for studying/analyzing with Machine Learning.

## Available packages

- Python 3.4.0 with miniconda3 on pyenv
- IPython Notebook
- numpy, scipy, matplotlib, scikit-learn, chainer, nltk, gensim

## Usage

### Launch IPython Notebook on current directory

```
$ docker run --rm -v $(pwd):/workdir -p 8888:8888 -it uetchy/ml ipynb
$ open http://$(docker-machine ip <your machine name>):8888
```

### Run python REPL

```
$ docker run --rm -it uetchy/ml python
```

## Get the image from DockerHub

Soon.
