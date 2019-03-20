default: build

build:
	docker build -t uetchy/ml:base .
	docker build -t uetchy/ml:tensorflow ./tensorflow
	docker build -t uetchy/ml:pytorch ./pytorch
	docker build -t uetchy/ml:chainer ./chainer

test: build
	docker run --runtime=nvidia --rm -it uetchy/ml:tensorflow test

publish: build
	docker push uetchy/ml:base
	docker push uetchy/ml:tensorflow
	docker push uetchy/ml:pytorch
	docker push uetchy/ml:chainer

bash:
	docker run --runtime=nvidia --rm -it uetchy/ml:base bash

jupyter:
	docker run --runtime=nvidia --rm -p 8888:8888 -it uetchy/ml:base jupyter
