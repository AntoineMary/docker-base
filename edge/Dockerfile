FROM alpine:edge as build

COPY assets /assets
RUN mv /assets/entrypoint.sh /
RUN chmod +x /entrypoint.sh

RUN addgroup -S app
RUN adduser -D -H app -g app -G app -s /sbin/nologin

RUN apk add --no-cache --virtual .run-deps su-exec

#####
FROM scratch
LABEL maintainer="Antoine Mary <antoinee.mary@gmail.com>"
COPY --from=build / /
ENTRYPOINT ["/entrypoint.sh"]
