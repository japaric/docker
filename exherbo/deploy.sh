#!/bin/bash

set -ex

tag=$(date +%F)

mounted=()
smount() {
    sudo mount --bind "$1" "$2"
    mounted+=( "$2")
}

sumount() {
    for ((i=${#mounted[@]}-1; i>=0; i--)); do
        sudo umount ${mounted[i]}
    done
}

build() {
    local tarball=exherbo-amd64-current.tar
    local url=http://dev.exherbo.org/stages/exherbo-amd64-current.tar.xz

    mkdir scratch
    cp $(dirname $0)/uninstall.sh scratch
    pushd scratch

    curl $url | sudo tar xJp
    for d in dev dev/pts proc sys; do
        smount /$d $(pwd)/$d
    done
    sudo cp /etc/resolv.conf etc
    sudo chroot . sh /uninstall.sh
    sudo chroot . cave sync
    sudo rm uninstall.sh
    sumount
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
