BIN_NAME = the_binary_name
CURRENT_TAG := $(shell git describe --tags | sed -e 's/^v//')
ARCH = amd64

DOCKER_FILE = tools/docker/Dockerfile
DOCKER_REPO = username/repo

release:
	GOOS=linux GOARCH=$(ARCH) go build -o releases/$(BIN_NAME)-$(CURRENT_TAG)-linux-$(ARCH) main.go
	GOOS=freebsd GOARCH=$(ARCH) go build -o releases/$(BIN_NAME)-$(CURRENT_TAG)-freebsd-$(ARCH) main.go
	GOOS=darwin GOARCH=$(ARCH) go build -o releases/$(BIN_NAME)-$(CURRENT_TAG)-darwin-$(ARCH) main.go
	GOOS=windows GOARCH=$(ARCH) go build -o releases/$(BIN_NAME)-$(CURRENT_TAG)-windows-$(ARCH).exe main.go

image:
	docker build . -f $(DOCKER_FILE) -t $(DOCKER_REPO):$(CURRENT_TAG)
	docker build . -f $(DOCKER_FILE) -t $(DOCKER_REPO):latest

version:
	@echo $(CURRENT_TAG)

default: release
