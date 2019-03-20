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
  python -c "import torch; print('PyTorch', torch.__version__, torch.cuda.current_device())"
  ;;
*)
  $@
  ;;
esac

exit 0
