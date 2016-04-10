FROM ubuntu:15.10

COPY passwordless-sudo.sh setup.sh /
RUN bash /setup.sh

USER particle
WORKDIR /home/particle
ENV PATH=$PATH:/home/particle/.cargo/bin USER=particle
CMD rustup default nightly; \
    cargo install --git https://github.com/japaric/xargo; \
    bash
