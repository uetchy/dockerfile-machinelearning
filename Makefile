default: build

build:
	docker build -t ml .

run:
	docker run --rm -it ml

jupyter:
	docker run --rm -p 8888:8888 -it ml jupyter
