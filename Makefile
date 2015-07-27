build:
	docker build -t ml .

run:
	docker run --rm -it ml

ipynb:
	docker run --rm -p 8888:8888 -it ml ipynb
