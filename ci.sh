#!/bin/bash

set -ex

main() {
    if [ "$TRAVIS_BRANCH" = "deploy-$IMAGE" ] && [ "$TRAVIS_PULL_REQUEST" == false ]; then
        set +x
        docker login -e="$DOCKER_EMAIL" -u="$DOCKER_USER" -p="$DOCKER_PASS"
        set -x
        bash $IMAGE/deploy.sh
    else
        bash $IMAGE/deploy.sh --test-only
    fi
}

main
