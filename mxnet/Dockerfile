FROM uetchy/ml:base

# MXNet
RUN git clone --depth 1 --recursive https://github.com/dmlc/mxnet /usr/src/mxnet && \
  pip install mxnet-cu100

COPY runner.sh /workspace/runner.sh
ENTRYPOINT ["/workspace/runner.sh"]