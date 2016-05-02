FROM ubuntu:16.04

COPY rust/setup.sh /
RUN bash /setup.sh

WORKDIR /home/rust
USER rust
ENV USER=rust
CMD bash
