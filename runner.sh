#!/bin/bash
set -e

case "$1" in
  "")
    bash
    ;;
  jupyter)
    jupyter notebook --no-browser --ip='*'
    ;;
  *)
    $@
    ;;
esac

exit 0
