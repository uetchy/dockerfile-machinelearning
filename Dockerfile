FROM ubuntu:14.04
MAINTAINER Yasuaki Uechi (http://randompaper.co)

ENV HOME /root
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

# Install dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  curl \
  git \
  vim \
  libreadline-dev \
  libssl-dev \
  libbz2-dev \
  libopenblas-dev \
  libatlas-dev \
  liblapack-dev \
  libhdf5-dev \
  imagemagick

RUN curl -sL https://deb.nodesource.com/setup | bash -

# Install python
RUN git clone git://github.com/yyuu/pyenv.git $PYENV_ROOT
RUN pyenv install 3.4.3
RUN pyenv global 3.4.3

# Install python components
RUN pip install -U pip
RUN pip install -U Cython
RUN pip install -U \
  numpy \
  scipy \
  matplotlib \
  h5py \
  jupyter \
  scikit-learn \
  scikit-image \
  nltk \
  gensim

# Prepare for installation from source
RUN mkdir /src

# Chainer
RUN pip install -U chainer

# TensorFlow
RUN pip install -U https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.6.0-cp34-none-linux_x86_64.whl

# Theano
RUN git clone git://github.com/Theano/Theano.git /src/theano
RUN cd /src/theano && python setup.py install

# Keras
RUN pip install keras

# Lasagne
RUN pip install Lasagne

# Torch7
RUN curl -s https://raw.githubusercontent.com/torch/ezinstall/master/install-deps | bash
RUN git clone https://github.com/torch/distro.git /src/torch --recursive; cd /src/torch; ./install.sh

# CNTK
# soon

# Pylearn2 (no longer actively developed)
# ENV PYLEARN2_DATA_PATH /data/lisa/data
# ENV PYLEARN2_ROOT /src/pylearn2
# ENV PATH $PYLEARN2_ROOT/bin:$PATH
# RUN git clone git://github.com/lisa-lab/pylearn2.git /src/pylearn2
# RUN cd /src/pylearn2 && echo install | python setup.py install

# Add runner script
COPY runner.sh /root/runner.sh
RUN chmod +x /root/runner.sh

# Set the working directory
WORKDIR /app
VOLUME /app

ENTRYPOINT ["/root/runner.sh"]
