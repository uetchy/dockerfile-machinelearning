FROM uetchy/ml:base

RUN pip install tensorflow-gpu tensorboard

# RUN apt-get install openjdk-8-jdk -y && \
#   echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" >> /etc/apt/sources.list.d/bazel.list && \
#   curl https://bazel.build/bazel-release.pub.gpg | apt-key add - && \
#   apt-get update && \
#   apt-get install bazel -y
# see https://gist.github.com/PatWie/0c915d5be59a518f934392219ca65c3d
# and https://github.com/tensorflow/tensorflow/blob/master/configure.py
# and https://github.com/tensorflow/tensorflow/blob/master/tools/bazel.rc
# for noninteractive tf build
# RUN git clone --depth 1 -b r1.7 https://github.com/tensorflow/tensorflow.git /usr/src/tensorflow && \
#   cd /usr/src/tensorflow && \
#   PYTHON_BIN_PATH=$(which python) \
#   PYTHON_LIB_PATH="$($PYTHON_BIN_PATH -c 'import site; print(site.getsitepackages()[0])')" \
#   CUDA_TOOLKIT_PATH=/usr/local/cuda \
#   CUDNN_INSTALL_PATH=/usr \
#   TF_NEED_GCP=0 \
#   TF_NEED_CUDA=1 \
#   TF_CUDA_VERSION="$($CUDA_TOOLKIT_PATH/bin/nvcc --version | sed -n 's/^.*release \(.*\),.*/\1/p')" \
#   TF_CUDA_COMPUTE_CAPABILITIES=6.1,5.2,3.5 \
#   TF_NEED_HDFS=0 \
#   TF_NEED_OPENCL=0 \
#   TF_NEED_JEMALLOC=1 \
#   TF_ENABLE_XLA=0 \
#   TF_NEED_VERBS=0 \
#   TF_CUDA_CLANG=0 \
#   TF_CUDNN_VERSION="$(sed -n 's/^#define CUDNN_MAJOR\s*\(.*\).*/\1/p' $CUDNN_INSTALL_PATH/include/cudnn.h)" \
#   TF_NEED_MKL=0 \
#   TF_DOWNLOAD_MKL=0 \
#   TF_NEED_MPI=0 \
#   TF_NEED_OPENCL_SYCL=0 \
#   TF_NEED_S3=0 \
#   TF_NEED_KAFKA=0 \
#   TF_NEED_TENSORRT=0 \
#   TF_NEED_GDR=0 \
#   TF_SET_ANDROID_WORKSPACE=0 \
#   GCC_HOST_COMPILER_PATH=$(which gcc) \
#   CC_OPT_FLAGS="-march=native" ./configure && \
#   bazel build --config=opt --config=cuda //tensorflow/tools/pip_package:build_pip_package && \
#   bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg && \
#   pip install /tmp/tensorflow_pkg/tensorflow-1.7.0-cp36-cp36m-linux_x86_64.whl
# cannot use GPUs within build process, you can also do GPU test manually:
# python -c 'import tensorflow as tf;sess = tf.Session(config=tf.ConfigProto(log_device_placement=True))'

COPY runner.sh /workspace/runner.sh
ENTRYPOINT ["/workspace/runner.sh"]
