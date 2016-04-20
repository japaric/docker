#!/bin/bash

set -ex

tag=$(date +%F)

build() {
    cd $(dirname $0)
    docker build -t japaric/photon:$tag -f Dockerfile ..
}

test() {
    docker run japaric/photon:$tag sh -c "
        rustup update
        cargo install --git https://github.com/crabtw/rust-bindgen
        git clone --branch latest --depth 1 https://github.com/spark/firmware
        cd firmware
        make
    "
}

deploy() {
    docker push japaric/photon
}

main() {
    build
    test

    if [ ! "$1" = "--test-only" ]; then
        deploy
    fi
}

main "$@"
