#!/bin/bash

set -ex

rm_stages_set() {
    cave purge -x
    cave uninstall python:3.5 --remove-if-dependent '*/*' -x
}

rm_cross_toolchain() {
    local target=i686-pc-linux-gnu

    cave uninstall -mx {glibc,libatomic,libgcc,libstdc++,linux-headers}::$target -u '*/*' -u system

    sed -i "s/ $target//" /etc/paludis/options.conf

    echo "*/* build_options: jobs=$(nproc)" >> /etc/paludis/options.conf
    cave resolve binutils eclectic-gcc gcc pkg-config -x1
    sed -i '$ d' /etc/paludis/options.conf

    rm -r /usr/$target
    rm -r /var/db/paludis/repositories/cross-installed
    rm /etc/paludis/repositories/$target.conf
    rm /var/cache/paludis/distfiles/*
    rm /var/log/paludis/*
}

main() {
    rm_stages_set
    rm_cross_toolchain
}

main
