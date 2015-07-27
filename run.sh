#!/bin/bash
set -e

case "$1" in
  py)
    python
    ;;
  ipynb)
    ipython notebook --no-browser --ip='*'
    ;;
  *)
    $@
    ;;
esac

exit 0
