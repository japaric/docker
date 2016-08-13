FROM ubuntu:16.04

COPY rustc-builtins/setup.sh /
RUN bash /setup.sh

ENV PATH=$PATH:/root/.cargo/bin \
    USER=root
CMD rustup default nightly; \
    bash
