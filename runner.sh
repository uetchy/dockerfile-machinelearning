#!/bin/bash

set -e

case "$1" in
  "")
    bash
    ;;
  jupyter)
    jupyter lab --no-browser --allow-root --ip='*'
    ;;
  test)
    python -c "import tensorflow as tf; print('TensorFlow', tf.__version__); tf.Session()"
    python -c "import chainer; print(chainer.cuda.available, chainer.cuda.cudnn_enabled)"
    ;;
  *)
    $@
    ;;
esac

exit 0
