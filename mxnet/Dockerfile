FROM uetchy/machine-learning:latest

# MXNet
RUN git clone --depth 1 --recursive https://github.com/dmlc/mxnet /usr/src/mxnet && \
  pip install mxnet-cu90

COPY runner.sh /project/runner.sh
RUN chmod +x /project/runner.sh
ENTRYPOINT ["runner.sh"]