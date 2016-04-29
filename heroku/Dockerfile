FROM ubuntu:16.04

COPY heroku/setup.sh /
RUN bash /setup.sh

WORKDIR /home/heroku
USER heroku
ENV USER=heroku
CMD bash
