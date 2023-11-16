#!/bin/sh

SPECTRO_VERSION="4.1.0-dev"
VERSION="v1.3.1-spectro-"
IMG_REPO="gcr.io/spectro-images-public/release/jetstack/cert-manager"
BUILDER_GOLANG_VERSION="1.21"

## dev repo ## 
#IMG_REPO="gcr.io/spectro-dev-public/${USER}/cert-manager"

make _bin/scratch/cert-manager.licenses_notice
make _bin/scratch/cert-manager.license

docker buildx create --use

docker buildx build --build-arg BUILDER_GOLANG_VERSION=${BUILDER_GOLANG_VERSION} --push \
--platform linux/arm64,linux/amd64 \
--tag ${IMG_REPO}/cert-manager-controller:${VERSION} . -f ./Dockerfile.nonfips --target controller

docker buildx build --build-arg BUILDER_GOLANG_VERSION=${BUILDER_GOLANG_VERSION} --push \
--platform linux/arm64,linux/amd64 \
--tag ${IMG_REPO}/cert-manager-webhook:${VERSION} . -f ./Dockerfile.nonfips --target webhook

docker buildx build --build-arg BUILDER_GOLANG_VERSION=${BUILDER_GOLANG_VERSION} --push \
--platform linux/arm64,linux/amd64 \
--tag ${IMG_REPO}/cert-manager-cainjector:${VERSION} . -f ./Dockerfile.nonfips --target cainjector

docker buildx build --build-arg BUILDER_GOLANG_VERSION=${BUILDER_GOLANG_VERSION} --push \
--platform linux/arm64,linux/amd64 \
--tag ${IMG_REPO}/cert-manager-acmesolver:${VERSION} . -f ./Dockerfile.nonfips --target acmesolver

