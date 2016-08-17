set -ex

user=rust

targets=(
    mips-unknown-linux-uclibc
    mipsel-unknown-linux-uclibc
)

as_user() {
    su -c 'bash -c "'"${@}"'"' $user
}

mk_user() {
    useradd -m $user
}

install_deps() {
    apt-get update

    apt-get install -y --no-install-recommends \
            `# rust` ca-certificates cmake curl file g++ gdb git libc6-dev llvm-dev make python sudo zlib1g-dev \
            `# openwrt` automake bison bzip2 flex gawk gperf help2man libncurses-dev libtool-bin patch texinfo wget

    # HACK AFAICT, there's no way to tell rustbuild to not depend on the FileCheck binary (i.e.
    # --disable-codegen-tests doesn't remove this dependency) and Ubuntu's llvm-dev package doesn't
    # provide this binary. We hack around this problem by creating a fake FileCheck.
    touch /usr/bin/FileCheck
}

mk_sudo_passwordless() {
    # See http://stackoverflow.com/a/28382838
    echo 'ALL ALL=(ALL) NOPASSWD: ALL' | (EDITOR="tee -a" visudo)
}

mk_crosstool_ng() {
    local version=1.22.0
    
    curl http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-${version}.tar.bz2 | tar xj
    pushd crosstool-ng
    ./configure --prefix=/usr/local
    make
    make install
    popd
    rm -rf crosstool-ng

    mkdir /x-tools
    chown $user:$user /x-tools
}

mk_toolchain() {
    as_user "
mkdir ~/ct
pushd ~/ct
cp /${1}.config .config
ct-ng oldconfig
ct-ng build
popd
rm -rf ~/ct
"

    for f in /x-tools/${1}/bin/${1}-*; do
        local g=$(basename $f)
        ln -s $f /usr/bin/${g//unknown-/}
    done
}

install_rustup() {
    curl https://sh.rustup.rs -sSf | sh -s -- -y
}

configure_cargo() {
    cat >>~/.cargo/config <<EOF
[target.$1]
linker = "${1//unknown-/}-gcc"
EOF
}

cleanup() {
    rm /setup.sh
    rm /*.config
}

main() {
    local target=

    mk_user
    install_deps
    mk_sudo_passwordless
    mk_crosstool_ng
    for target in "${targets[@]}"; do
        mk_toolchain $target
    done
    install_rustup
    for target in "${targets[@]}"; do
        configure_cargo $target
    done
    cleanup
}

main
