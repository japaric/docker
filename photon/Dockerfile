FROM ubuntu:15.10

COPY passwordless-sudo.sh photon/setup.sh /
RUN bash /setup.sh

USER particle
WORKDIR /home/particle
ENV PATH=$PATH:/home/particle/.cargo/bin USER=particle
CMD rustup update; \
    cargo install xargo; \
    bash
