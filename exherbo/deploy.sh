#!/bin/bash

set -ex

tag=$(date +%F)

build() {
    local tarball=exherbo-amd64-current.tar
    local url=http://dev.exherbo.org/stages/exherbo-amd64-current.tar.xz

    mkdir scratch
    cp $(dirname $0)/uninstall.sh scratch
    pushd scratch

    curl $url | sudo tar xJp
    sudo systemd-nspawn sh /uninstall.sh
    sudo rm uninstall.sh
    sudo tar --numeric-owner -cpf ../$tarball .

    popd
    sudo rm -rf scratch

    docker import -c 'CMD bash' $tarball japaric/exherbo:$tag
    sudo rm $tarball
}

test() {
    docker run japaric/exherbo:$tag sh -c "
        cave sync
    "
}

deploy() {
    docker push japaric/exherbo
}

main() {
    build
    test

    if [ ! "$1" = "--test-only" ]; then
        deploy
    fi
}

main "$@"
