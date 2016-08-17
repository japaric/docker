#!/bin/bash

set -ex

tag=$(date +%F)

build() {
    cd $(dirname $0)
    docker build -t japaric/rust-uclibc:$tag -f Dockerfile ..
}

test() {
    true
}

deploy() {
    docker push japaric/rust-uclibc
}

main() {
    build
    test

    if [ ! "$1" = "--test-only" ]; then
        deploy
    fi
}

main "$@"
