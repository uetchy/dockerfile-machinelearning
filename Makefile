default: build

build:
	docker build -t uetchy/machinelearning:base .
	docker build -t uetchy/machinelearning:tensorflow ./tensorflow
	docker build -t uetchy/machinelearning:pytorch ./pytorch
	docker build -t uetchy/machinelearning:chainer ./chainer
	docker build -t uetchy/machinelearning:mxnet ./mxnet
	docker build -t uetchy/machinelearning:xgboost ./xgboost

publish: build
	docker push uetchy/machinelearning:base
	docker push uetchy/machinelearning:tensorflow
	docker push uetchy/machinelearning:pytorch
	docker push uetchy/machinelearning:chainer
	docker push uetchy/machinelearning:mxnet
	docker push uetchy/machinelearning:xgboost

bash:
	docker run --runtime=nvidia --rm -it uetchy/machinelearning:base bash

jupyter:
	docker run --runtime=nvidia --rm -p 8888:8888 -it uetchy/machinelearning:base jupyter
