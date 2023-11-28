DOCKER_IMAGE_VERSION := 1.0
DOCKER_IMAGE := games-api:v$(DOCKER_IMAGE_VERSION)
CONTAINER_NAME := games-api
SRC := main.go
OUT := gserver
GET_CONTAINER_NAME := $(shell docker container ls -a --format "{{.Names}}" --filter "name=$(CONTAINER_NAME)")
GET_CONTAINER_IMAGE := $(shell docker image ls --format "{{.Repository}}" --filter=reference=$(DOCKER_IMAGE))

ifeq ($(GET_CONTAINER_NAME), $(CONTAINER_NAME))
container-up: image-build
	@echo "Container Exists"
else
container-up: image-build
	@docker container run -it -d -p 8080:8080 --rm --name $(CONTAINER_NAME) $(DOCKER_IMAGE)
endif

container-down:
	@docker container rm -f $(CONTAINER_NAME)

ifneq ($(GET_CONTAINER_IMAGE), $(CONTAINER_NAME))
image-build:
	@docker image build -t $(DOCKER_IMAGE) .
else
image-build:
	@echo "Image Exists"
endif

build:
	@go build -o $(OUT) $(SRC)

run:
	@./$(OUT)

clean:
	@rm -f $(OUT)

