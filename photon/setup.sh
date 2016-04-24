# See https://github.com/spark/firmware/blob/latest/docs/dependencies.md

set -ex

user=particle

as_user() {
    su -c 'bash -c "'"${@}"'"' $user
}

mk_user() {
    useradd -m $user
}

install_deps() {
    apt-get update

    # libarchive-zip-perl for `crc32`
    # vim-common for `xxd`
    # libc6-i386 needed to run `arm-none-eabi-*` commands, which are 32-bit programs
    apt-get install -y --force-yes --no-install-recommends \
            bzip2 ca-certificates curl dfu-util file git libarchive-zip-perl libc6-i386 make sudo vim-common

    # GCC for ARM
    curl -sL "https://launchpad.net/gcc-arm-embedded/4.9/4.9-2015-q3-update/+download/gcc-arm-none-eabi-4_9-2015q3-20150921-linux.tar.bz2" | \
        tar --strip-components 1 -C /usr/local -xj

    # for xargo
    apt-get install -y --force-yes --no-install-recommends \
            gcc libssl-dev

    # for particle-cli
    apt-get install -y --force-yes --no-install-recommends \
            npm
    ln -s /usr/bin/nodejs /usr/local/bin/node

    npm -g install particle-cli

    # for bindgen
    apt-get install -y --force-yes --no-install-recommends \
            libclang-dev
}

install_rust_stuff() {
    as_user '
set -ex
curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain=stable -y
cd ~
source ~/.cargo/env
cargo install xargo
rustup toolchain remove stable
'
}

mk_sudo_passwordless() {
    bash /passwordless-sudo.sh
}

cleanup() {
    rm /{passwordless-sudo,setup}.sh
}

main() {
    mk_user
    install_deps
    install_rust_stuff
    mk_sudo_passwordless
    cleanup
}

main
