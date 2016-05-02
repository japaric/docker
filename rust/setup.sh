set -ex

user=rust

as_user() {
    su -c 'bash -c "'"${@}"'"' $user
}

mk_user() {
    useradd -m $user
}

install_deps() {
    apt-get update

    apt-get install -y --no-install-recommends \
            ca-certificates cmake curl file gcc gdb git make python sudo
}

mk_sudo_passwordless() {
    # See http://stackoverflow.com/a/28382838
    echo 'ALL ALL=(ALL) NOPASSWD: ALL' | (EDITOR="tee -a" visudo)
}

cleanup() {
    rm /setup.sh
}

main() {
    mk_user
    install_deps
    mk_sudo_passwordless
    cleanup
}

main
