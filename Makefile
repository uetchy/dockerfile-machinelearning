default: build

build:
	docker build -t uetchy/machinelearning .
	docker run --runtime=nvidia --rm -it uetchy/machinelearning

run:
	docker run --runtime=nvidia --rm -it uetchy/machinelearning

jupyter:
	docker run --runtime=nvidia --rm -p 8888:8888 -it uetchy/machinelearning jupyter
