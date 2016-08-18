#!/bin/bash

set -ex

fetch_sources() {
    # Switch to rust-lang/rust when rust-lang/rust#35734 lands
    git clone --depth 1 --branch mips-uclibc https://github.com/japaric/rust ~/rust
    git clone --branch uclibc  https://github.com/japaric/libc ~/libc
}

# See rust-lang/rust#34486
workaround_gh34486() {
    cat >> ~/rust/src/librustc_llvm/lib.rs <<EOF
#[link(name = "ffi")] extern {}
EOF
}

install_qemu() {
    sudo apt-get install -y --no-install-recommends \
         binfmt-support qemu-user-static
}

# FIXME This should have been installed in the docker image
install_rustup() {
    curl https://sh.rustup.rs -sSf | sh -s -- -y
}

build_rust() {
    mkdir ~/build
    pushd ~/build
    ../rust/configure --enable-rustbuild --llvm-root=/usr --target=$1
    make
    rustup toolchain link stage2 build/x86_64-unknown-linux-gnu/stage2
    rustup default stage2
    popd
}

run_libc_ctest() {
    pushd ~/libc/libc-test
    cargo run --target $1
    popd
}

main() {
    fetch_sources
    workaround_gh34486
    install_qemu
    install_rustup
    source ~/.cargo/env
    build_rust "${@}"
    run_libc_ctest "${@}"
}

main "${@}"
