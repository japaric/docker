#!/bin/bash

set -ex

tag=$(date +%F)

build() {
    cd $(dirname $0)
    docker build -t japaric/rust:$tag -f Dockerfile ..
}

test() {
    docker run japaric/rust:$tag sh -c "
set -ex
git clone --depth 1 https://github.com/rust-lang/rust
mkdir build
cd build
../rust/configure --enable-rustbuild
"
}

deploy() {
    docker push japaric/rust
}

main() {
    build
    test

    if [ ! "$1" = "--test-only" ]; then
        deploy
    fi
}

main "$@"
