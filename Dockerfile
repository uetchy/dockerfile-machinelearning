FROM ubuntu:14.04
MAINTAINER Yasuaki Uechi <http://randompaper.co>

RUN apt-get update -y
RUN apt-get install build-essential wget curl git -y
RUN git clone git://github.com/yyuu/pyenv.git $HOME/.pyenv
ENV HOME /root
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
RUN pyenv install miniconda3-3.10.1
RUN pyenv global miniconda3-3.10.1
RUN conda update --all -y
RUN conda install numpy scipy matplotlib ipython ipython-notebook scikit-learn nltk gensim -y
RUN pip install chainer

COPY run.sh /root/run.sh
RUN chmod +x /root/run.sh

WORKDIR /workdir
VOLUME /workdir

ENTRYPOINT ["/root/run.sh"]
