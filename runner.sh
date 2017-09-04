#!/bin/bash
set -e

case "$1" in
  "")
    bash
    ;;
  jupyter)
    jupyter notebook --no-browser --allow-root --ip='*'
    ;;
  *)
    $@
    ;;
esac

exit 0
