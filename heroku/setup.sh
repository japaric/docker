set -ex

user=heroku

as_user() {
    su -c 'bash -c "'"${@}"'"' $user
}

mk_user() {
    useradd -m $user
}

install_deps() {
    apt-get update

    # rustup
    apt-get install -y --force-yes --no-install-recommends \
            ca-certificates sudo wget
}

install_heroku() {
    as_user '
set -ex
wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
heroku version
'
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
    install_heroku
    cleanup
}

main
