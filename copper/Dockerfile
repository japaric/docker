FROM ubuntu:16.04

COPY copper/setup.sh /
RUN bash /setup.sh

WORKDIR /home/copper
USER copper
ENV PATH=$PATH:/home/copper/.cargo/bin USER=copper
CMD rustup default nightly; \
    bash
