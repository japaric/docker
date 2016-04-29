#!/bin/bash

set -ex

tag=$(date +%F)

build() {
    cd $(dirname $0)
    docker build -t japaric/heroku:$tag -f Dockerfile ..
}

deploy() {
    docker push japaric/heroku
}

main() {
    build

    if [ ! "$1" = "--test-only" ]; then
        deploy
    fi
}

main "$@"
