TAG=v0.0.1
NAME=xelit/go-api

build:
	docker build . -t $(NAME):$(TAG)

push:
	docker push $(NAME):$(TAG)

run:
	docker run -it -p 8080:8080 $(NAME):$(TAG)