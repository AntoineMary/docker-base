# Alpine base image
[![Build Status][project-build-image]][project-build-link] [![Docker Build][docker-build-image]][docker-build-link] [![Docker Stars][docker-stars-image]][docker-stars-link] [![Docker Pulls][docker-pulls-image]][docker-pulls-link]

[![MicroBadger Version][micro-version-image]][micro-version-links] [![MicroBadger Layers][micro-layers-image]][micro-layers-link] [![MicroBadger Size][micro-size-image]][micro-size-link]

This docker is a base image, it's not recommended to use as is.
___

# What is Alpine
[![Alpine][alpine-image]][alpine]
> Alpine Linux is a Linux distribution built around musl libc and BusyBox. The image is only 5 MB in size and has access to a package repository that is much more complete than other BusyBox based images. This makes Alpine Linux a great image base for utilities and even production applications. Read more about Alpine Linux here and you can see how their mantra fits in right at home with Docker images.

[https://alpinelinux.org/][alpine]

# About this image

This image will be update after each new push of [Alpine][alpine-link] but internal script will be update according to the label in the [Dockerfile][dockerfile]

The purpose of this image is to give an already setup environment in which you just have to install missing packages for you application and add it into. ** Use this image as a base image **

- It have been build from the official [Alpine][alpine-link]
- Every package is up-to-date
- It embed some scripts to easily change timezone/user for example at each startup
- An entrypoint that give you the possibility to run scripts :
  - At each startup system wide
  - Just before the start of your application
  - Just after the stop of you application
  - Before the shutdown

# How to use this image

if you want to explore the image before using it :
```
docker pull amary/base:{latest,3.7,3.6,3.5,3.4,3.3,3.2}
docker run -it amary/base /bin/sh
```
** As it is a base no cmd have been setup **

If you want to use it as a base you can do this way :
```
FROM alpine:latest as build
# All your instruction
# to build your app

FROM amary/base
ENV APP_NAME="My App" \
    APP_VERSION="My App version" \
    APP_LOCATION="/my/app/location" \
    UID="100" \
    GID="101" \
    TZ="UTC" \
    NAMED_TZ=""

COPY --from=build /my/app/location /my/app/location
# RUN apk add ....
# Additionnal instruction

EXPOSE ....
VOLUMES ....

CMD["/my/app/location", "ARG1", "ARG2", ...]
```

| ENV name | Description | Required | Accepted value | Default |
|----------|-------------|----------|----------------|---------|
| APP_NAME | The name of your application | yes | everything | "" |
| APP_LOCATION | The path to you application binary | yes | a valid path | "" |
| UID | User id desired to launch application | no | Number | 100 |
| GID | Group id desired to launch application | no | Number | 101 |
| TZ | Timezone inside docker | no | [PATH // POSIX // last line of zoneinfo file][tz-link]| UTC |
| NAMED_TZ | Allow to use zoneinfo name for TZ| no | 1 | ""

# Changelog
v1.0.0 : Initial release

[//]: # (==== Reference Part ====)

[//]: # (External Websites)
[alpine]: https://alpinelinux.org/
[alpine-image]: https://raw.githubusercontent.com/docker-library/docs/781049d54b1bd9b26d7e8ad384a92f7e0dcb0894/alpine/logo.png
[alpine-link]: https://hub.docker.com/_/alpine/
[dockerfile]: https://github.com/AntoineMary/docker-base/blob/master/Dockerfile
[tz-link]:https://wiki.musl-libc.org/environment-variables.html#TZ

[//]: # (Badges)
[project-build-image]: https://img.shields.io/docker/build/amary/base.svg
[project-build-link]: https://hub.docker.com/r/amary/base/builds/

[docker-build-image]: https://img.shields.io/docker/automated/amary/base.svg
[docker-build-link]: https://hub.docker.com/r/amary/base/

[docker-stars-image]: https://img.shields.io/docker/stars/amary/base.svg
[docker-stars-link]: https://hub.docker.com/r/amary/base/

[docker-pulls-image]: https://img.shields.io/docker/pulls/amary/base.svg
[docker-pulls-link]: https://hub.docker.com/r/amary/base/

[micro-size-image]:https://img.shields.io/microbadger/image-size/amary/base.svg
[micro-size-link]: https://microbadger.com/images/amary/base

[micro-layers-image]:	https://img.shields.io/microbadger/layers/amary/base.svg
[micro-layers-link]: https://microbadger.com/images/amary/base

[micro-version-image]: https://images.microbadger.com/badges/version/amary/base.svg
[micro-version-links]: https://microbadger.com/images/amary/base
