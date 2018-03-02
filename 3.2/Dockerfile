FROM alpine:3.2 as build

RUN addgroup -S app
RUN adduser -D -G app -H -s /sbin/nologin -S app

RUN apk --no-cache upgrade
RUN apk add --no-cache --virtual .run-deps su-exec

COPY assets /assets
RUN chmod -R 700 /assets/*/*_* /assets/entrypoint.sh
RUN mv /assets/entrypoint.sh /

RUN date > /assets/build_date

#####
FROM scratch
LABEL maintainer="Antoine Mary <antoinee.mary@gmail.com>"
ENV APP_NAME="" \
    APP_VERSION="" \
    APP_LOCATION="" \
    UID="" \
    GID="" \
    TZ="" \
    NAMED_TZ=""

COPY --from=build / /
ENTRYPOINT ["/entrypoint.sh"]
