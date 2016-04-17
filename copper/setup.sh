set -ex

user=copper

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
    ca-certificates curl

  apt-get install -y --force-yes --no-install-recommends \
    sudo

  # copper
  apt-get install -y --force-yes --no-install-recommends \
    gcc gcc-arm-none-eabi gdb-arm-none-eabi git libc6-dev libcurl4-openssl-dev libssl-dev openocd \
    pkg-config qemu-system-arm
}

install_rustup() {
  as_user "
    curl https://raw.githubusercontent.com/japaric/multirust-rs/no-tty/rustup-setup.sh -sSf | \
      sh -s -- --default-toolchain=nightly -y
  "
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
  install_rustup
  mk_sudo_passwordless
  cleanup
}

main
