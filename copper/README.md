[![Docker Stars](https://img.shields.io/docker/stars/japaric/copper.svg)](https://hub.docker.com/r/japaric/copper/)
[![Docker Pulls](https://img.shields.io/docker/pulls/japaric/copper.svg)](https://hub.docker.com/r/japaric/copper/)

# `copper`

> Docker image with all the dependencies needed to work with the [copper] project.

[copper]: https://github.com/japaric/cu

## Usage

```
$ docker run -it japaric/copper:2016-05-03
# or use a newer tag. See https://hub.docker.com/r/japaric/copper/tags/
```

## Changelog

- 2016-05-03
  - Set the CC and AR env variables needed to build the compiler-rt crate.

- 2016-04-26
  - Fix passwordless sudo
  - Install newlib headers which are required to cross compile compiler-rt with arm-none-eabi-gcc

- 2016-04-25
  - Bump xargo to 0.1.3

- 2016-04-22
  - Based on Ubuntu 16.04 instead of Ubuntu 15.10
  - Ships with pre-compiled xargo-0.1.1 (built with rust-1.8.0)
  
- 2016-04-10
  - Initial release
  - Based on Ubuntu 15.10
