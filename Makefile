default: build test

build:
	docker build -t uetchy/machinelearning .
	docker build -t uetchy/machinelearning:chainer ./chainer

run:
	docker run --runtime=nvidia --rm -it uetchy/machinelearning

test:
	docker run --runtime=nvidia --rm -it uetchy/machinelearning test

jupyter:
	docker run --runtime=nvidia --rm -p 8888:8888 -it uetchy/machinelearning jupyter
