# `copper`

> Docker image with all the dependencies needed to work with the [copper] project.

[copper]: https://github.com/japaric/cu

## Usage

```
$ docker run -it japaric/copper:2016-04-24
# or use a newer tag. See https://hub.docker.com/r/japaric/copper/tags/
```

## Changelog

- 2016-04-24
  - Bump xargo to 0.1.2

- 2016-04-22
  - Based on Ubuntu 16.04 instead of Ubuntu 15.10
  - Ships with pre-compiled xargo-0.1.1 (built with rust-1.8.0)
  
- 2016-04-10
  - Initial release
  - Based on Ubuntu 15.10
