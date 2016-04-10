#!/bin/bash

build() {
    cd $(dirname $0)
    docker build -t japaric/photon:$(date +%F) .
}

test() {
    docker run japaric/photon sh -c "
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
