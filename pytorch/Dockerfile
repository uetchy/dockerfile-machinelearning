FROM uetchy/ml:base

# PyTorch
RUN git clone --depth 1 https://github.com/pytorch/tutorials.git /usr/src/pytorch-tutorials && \
  conda config --prepend channels pytorch && \
  conda install pytorch torchvision cuda100 -y

RUN pip install tensorboardX

# Apex
RUN git clone --depth 1 https://github.com/NVIDIA/apex.git /usr/src/apex && \
  cd /usr/src/apex && python setup.py install --cuda_ext --cpp_ext

COPY runner.sh /workspace/runner.sh
ENTRYPOINT ["/workspace/runner.sh"]