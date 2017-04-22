default: build

build:
	nvidia-docker build -t uetchy/machinelearning .
	nvidia-docker run --rm -it uetchy/machinelearning

run:
	nvidia-docker run --rm -it uetchy/machinelearning

jupyter:
	nvidia-docker run --rm -p 8888:8888 -it uetchy/machinelearning jupyter
