FROM uetchy/machine-learning:latest

# Chainer
RUN git clone --depth 1 https://github.com/pfnet/chainer.git /usr/src/chainer && \
  pip install -U chainer cupy-cuda90

COPY runner.sh /project/runner.sh
RUN chmod +x /project/runner.sh
ENTRYPOINT ["runner.sh"]
