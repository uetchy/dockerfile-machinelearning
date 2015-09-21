FROM ubuntu:14.04
MAINTAINER Yasuaki Uechi (http://randompaper.co)

ENV HOME /root
ENV PYENV_ROOT $HOME/.pyenv
ENV PYLEARN2_DATA_PATH /data/lisa/data
ENV PYLEARN2_ROOT /src/pylearn2
ENV PATH $PYLEARN2_ROOT/bin:$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

# Install dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  curl \
  git \
  vim \
  libopenblas-dev \
  libatlas3gf-base

RUN curl -sL https://deb.nodesource.com/setup | bash -

# Install python
RUN git clone git://github.com/yyuu/pyenv.git $PYENV_ROOT
RUN pyenv install miniconda3-3.16.0
RUN pyenv global miniconda3-3.16.0

# Install ML components
RUN conda update --all -y
RUN conda install -y \
  numpy \
  scipy \
  matplotlib \
  jupyter \
  scikit-learn \
  nltk \
  gensim
RUN pip install \
  chainer

# Prepare for installation from source
RUN mkdir /src

# Theano
RUN git clone git://github.com/Theano/Theano.git /src/theano
RUN cd /src/theano && python setup.py install

# Pylearn2
RUN git clone git://github.com/lisa-lab/pylearn2.git /src/pylearn2
RUN cd /src/pylearn2 && echo install | python setup.py install

# Add runner script
COPY runner.sh /root/runner.sh
RUN chmod +x /root/runner.sh

# Set the working directory
WORKDIR /workdir
VOLUME /workdir

ENTRYPOINT ["/root/runner.sh"]
