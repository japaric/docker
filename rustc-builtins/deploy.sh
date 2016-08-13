#!/bin/bash

set -ex

tag=$(date +%F)

build() {
    cd $(dirname $0)
    docker build -t japaric/rustc-builtins:$tag -f Dockerfile ..
}

test() {
    docker run japaric/rustc-builtins:$tag sh -c "
set -ex
rustup default nightly
cargo new --bin hello
cd hello
rustup target add i586-unknown-linux-gnu
cargo run --target i586-unknown-linux-gnu
rustup target add i686-unknown-linux-gnu
cargo run --target i686-unknown-linux-gnu
cargo run --target x86_64-unknown-linux-gnu
rustup target add aarch64-unknown-linux-gnu
cargo build --target aarch64-unknown-linux-gnu
rustup target add arm-unknown-linux-gnueabi
cargo build --target arm-unknown-linux-gnueabi
rustup target add arm-unknown-linux-gnueabihf
cargo build --target arm-unknown-linux-gnueabihf
rustup target add armv7-unknown-linux-gnueabihf
cargo build --target armv7-unknown-linux-gnueabihf
rustup target add mips-unknown-linux-gnu
cargo build --target mips-unknown-linux-gnu
rustup target add mipsel-unknown-linux-gnu
cargo build --target mipsel-unknown-linux-gnu
rustup target add powerpc-unknown-linux-gnu
cargo build --target powerpc-unknown-linux-gnu
rustup target add powerpc64-unknown-linux-gnu
cargo build --target powerpc64-unknown-linux-gnu
rustup target add powerpc64le-unknown-linux-gnu
cargo build --target powerpc64le-unknown-linux-gnu
"
}

deploy() {
    docker push japaric/rustc-builtins
}

main() {
    build
    test

    if [ ! "$1" = "--test-only" ]; then
        deploy
    fi
}

main "$@"
