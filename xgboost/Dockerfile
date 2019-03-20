FROM uetchy/ml:base

# XGBoost
RUN git clone --depth 1 --recursive https://github.com/dmlc/xgboost /usr/src/xgboost && \
  mkdir /usr/src/xgboost/build && cd /usr/src/xgboost/build && \
  cmake .. -DUSE_CUDA=ON && \
  make -j4 && \
  cd ../python-package && python setup.py install

COPY runner.sh /workspace/runner.sh
ENTRYPOINT ["/workspace/runner.sh"]