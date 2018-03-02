#!/bin/sh
set -e

run-parts /assets/boot

if [ "x$1" = "x$APP_LOCATION" ]; then

    run-parts /assets/app/start

    exec su-exec app $@

    run-parts /assets/app/stop
else
    exec "$@"
fi

run-parts /assets/shutdown
