APP_NAME=deprek8ion

QUAY_REPO=swade1987
QUAY_USERNAME?="swade1987+deprek8ion"
QUAY_PASSWORD?="unknown"

CIRCLE_BUILD_NUM?="unknown"
VERSION=1.1.$(CIRCLE_BUILD_NUM)
IMAGE = quay.io/$(QUAY_REPO)/$(APP_NAME)

build:
	clear
	docker build \
	--build-arg KUBERNETES_VERSION=$(KUBERNETES_VERSION) \
	-t $(IMAGE) .

login:
	docker login -u $(QUAY_USERNAME) -p $(QUAY_PASSWORD) quay.io

logout:
	docker logout

push:
	docker push $(IMAGE)
	docker rmi $(IMAGE)