FROM ubuntu:16.04

COPY copper/setup.sh /
RUN bash /setup.sh

WORKDIR /home/copper
USER copper
ENV AR_thumbv7m_none_eabi=arm-none-eabi-ar \
    CC_thumbv7m_none_eabi=arm-none-eabi-gcc \
    PATH=$PATH:/home/copper/.cargo/bin \
    USER=copper
CMD rustup default nightly; \
    bash
