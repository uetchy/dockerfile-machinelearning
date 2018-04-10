default: build test

build:
	docker build -t uetchy/machinelearning .

run:
	docker run --runtime=nvidia --rm -it uetchy/machinelearning

test:
	docker run --runtime=nvidia --rm -it uetchy/machinelearning test

jupyter:
	docker run --runtime=nvidia --rm -p 8888:8888 -it uetchy/machinelearning jupyter
