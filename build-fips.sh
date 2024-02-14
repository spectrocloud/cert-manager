#!/bin/sh

VERSION="v1.3.1-spectro-"
if [[ $FIPS_REGISTRY ]]; then
  IMG_REPO=$FIPS_REGISTRY
else
  IMG_REPO="gcr.io/spectro-images-public/release-fips/jetstack/cert-manager"
fi
BUILDER_GOLANG_VERSION="1.21.6"

## dev repo ## 
#IMG_REPO="gcr.io/spectro-dev-public/${USER}/cert-manager"

make _bin/scratch/cert-manager.licenses_notice
make _bin/scratch/cert-manager.license

docker buildx create --use

docker buildx build --build-arg BUILDER_GOLANG_VERSION=${BUILDER_GOLANG_VERSION} --build-arg CRYPTO_LIB=${FIPS_ENABLE} --push \
--platform linux/arm64,linux/amd64 \
--tag ${IMG_REPO}/cert-manager-controller:${VERSION}$SPECTRO_VERSION . -f ./Dockerfile.fips --target controller

docker buildx build --build-arg BUILDER_GOLANG_VERSION=${BUILDER_GOLANG_VERSION} --build-arg CRYPTO_LIB=${FIPS_ENABLE} --push \
--platform linux/arm64,linux/amd64 \
--tag ${IMG_REPO}/cert-manager-webhook:${VERSION}$SPECTRO_VERSION . -f ./Dockerfile.fips --target webhook

docker buildx build --build-arg BUILDER_GOLANG_VERSION=${BUILDER_GOLANG_VERSION} --build-arg CRYPTO_LIB=${FIPS_ENABLE} --push \
--platform linux/arm64,linux/amd64 \
--tag ${IMG_REPO}/cert-manager-cainjector:${VERSION}$SPECTRO_VERSION . -f ./Dockerfile.fips --target cainjector

docker buildx build --build-arg BUILDER_GOLANG_VERSION=${BUILDER_GOLANG_VERSION} --build-arg CRYPTO_LIB=${FIPS_ENABLE} --push \
--platform linux/arm64,linux/amd64 \
--tag ${IMG_REPO}/cert-manager-acmesolver:${VERSION}$SPECTRO_VERSION . -f ./Dockerfile.fips --target acmesolver

