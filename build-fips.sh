#!/bin/sh

VERSION="spectro-v1.11.0"
IMG_REPO="gcr.io/spectro-images-public/release/jetstack/cert-manager"
BUILDER_GOLANG_VERSION="1.21"

## dev repo ## 
#IMG_REPO="gcr.io/spectro-dev-public/${USER}/cert-manager"

make _bin/scratch/cert-manager.licenses_notice
make _bin/scratch/cert-manager.license

docker buildx create --use

docker buildx build --build-arg BUILDER_GOLANG_VERSION=${BUILDER_GOLANG_VERSION} --build-arg CRYPTO_LIB=${FIPS_ENABLE} --push \
--platform linux/arm64,linux/amd64 \
--tag ${IMG_REPO}/cert-manager-controller:${VERSION}-fips . -f ./Dockerfile.fips --target controller

docker buildx build --build-arg BUILDER_GOLANG_VERSION=${BUILDER_GOLANG_VERSION} --build-arg CRYPTO_LIB=${FIPS_ENABLE} --push \
--platform linux/arm64,linux/amd64 \
--tag ${IMG_REPO}/cert-manager-webhook:${VERSION}-fips . -f ./Dockerfile.fips --target webhook

docker buildx build --build-arg BUILDER_GOLANG_VERSION=${BUILDER_GOLANG_VERSION} --build-arg CRYPTO_LIB=${FIPS_ENABLE} --push \
--platform linux/arm64,linux/amd64 \
--tag ${IMG_REPO}/cert-manager-cainjector:${VERSION}-fips . -f ./Dockerfile.fips --target cainjector

docker buildx build --build-arg BUILDER_GOLANG_VERSION=${BUILDER_GOLANG_VERSION} --build-arg CRYPTO_LIB=${FIPS_ENABLE} --push \
--platform linux/arm64,linux/amd64 \
--tag ${IMG_REPO}/cert-manager-acmesolver:${VERSION}-fips . -f ./Dockerfile.fips --target acmesolver

