#!/bin/sh
set -e

run-parts /assets/boot

if [ "x$1" = "x$APP_LOCATION" ]; then

    run-parts /assets/app/start

    echo "Starting $APP_NAME"
    exec su-exec app $@
    echo "$APP_NAME has stopped"

    run-parts /assets/app/stop
else
    exec "$@"
fi

run-parts /assets/shutdown
