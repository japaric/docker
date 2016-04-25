FROM ubuntu:16.04

COPY photon/setup.sh /
RUN bash /setup.sh

USER particle
WORKDIR /home/particle
ENV PATH=$PATH:/home/particle/.cargo/bin USER=particle
CMD rustup default nightly; \
    bash
