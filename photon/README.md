# `Photon`

> Docker image with all the dependencies needed to build Rust apps for the [particle] [photon].

[particle]: https://www.particle.io/
[photon]: https://store.particle.io/collections/photon

## Usage

```
$ docker run -it japaric/photon:2016-04-24
# or use a newer tag. See https://hub.docker.com/r/japaric/photon/tags/
```

## Changelog

- 2016-04-24
  - Bump xargo to 0.1.2

- 2016-04-22
  - Based on Ubuntu 16.04 instead of Ubuntu 15.10
  - Ships with pre-compiled xargo-0.1.1 (built with rust-1.8.0)
  
- 2016-04-11
  - Add rust-bindgen dependencies
  
- 2016-04-10
  - Initial release
  
- 2016-04-09
  - Test run
