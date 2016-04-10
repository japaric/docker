# `docker-photon`

> Docker image with all the dependencies needed to work with the [particle] [photon].

[particle]: https://www.particle.io/
[photon]: https://store.particle.io/collections/photon

## Usage

```
$ docker run -it japaric/photon:2016-04-09
# or use a newer tag. See https://hub.docker.com/r/japaric/photon/tags/
```

## Build and upload image

```
$ docker build -t japaric/photon:$(date +%F) .
$ docker push japaric/photon:$(date +%F)
```

## License

Licensed under either of

- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE) or
  http://www.apache.org/licenses/LICENSE-2.0)
- MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)

at your option.

### Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted for inclusion in the
work by you, as defined in the Apache-2.0 license, shall be dual licensed as above, without any
additional terms or conditions.
