default: build

build:
	docker build -t uetchy/machinelearning .

run:
	docker run --rm -it uetchy/machinelearning

jupyter:
	docker run --rm -p 8888:8888 -it uetchy/machinelearning jupyter
