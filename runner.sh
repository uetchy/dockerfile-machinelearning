#!/bin/bash
set -e

case "$1" in
  "")
    bash
    ;;
  ipynb)
    ipython notebook --no-browser --ip='*'
    ;;
  *)
    $@
    ;;
esac

exit 0
