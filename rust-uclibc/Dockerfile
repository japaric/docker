FROM ubuntu:16.04

COPY rust-uclibc/setup.sh \
    rust-uclibc/mips-unknown-linux-uclibc \
    rust-uclibc/mipsel-unknown-linux-uclibc \
    /
RUN bash /setup.sh

USER rust

ENV PATH=$PATH:/home/rust/.cargo/bin \
    USER=rust \
    CC_mips_unknown_linux_uclibc=mips-linux-uclibc-gcc \
    CC_mipsel_unknown_linux_uclibc=mipsel-linux-uclibc-gcc

CMD bash
