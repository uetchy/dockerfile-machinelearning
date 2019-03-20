FROM uetchy/ml:base

# Chainer
RUN git clone --depth 1 https://github.com/pfnet/chainer.git /usr/src/chainer && \
  pip install -U chainer cupy-cuda100

COPY runner.sh /workspace/runner.sh
ENTRYPOINT ["/workspace/runner.sh"]
