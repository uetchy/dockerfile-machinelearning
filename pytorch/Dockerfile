FROM nvidia/cuda:10.0-cudnn7-devel

# PyTorch
RUN git clone --depth 1 https://github.com/pytorch/tutorials.git /usr/src/pytorch-tutorials && \
  conda config --prepend channels pytorch && \
  conda install pytorch torchvision cuda90 -y

COPY runner.sh /project/runner.sh
RUN chmod +x /project/runner.sh
ENTRYPOINT ["runner.sh"]