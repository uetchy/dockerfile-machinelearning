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
    python -c "import chainer; chainer.print_runtime_info()"
    ;;
  *)
    $@
    ;;
esac

exit 0
