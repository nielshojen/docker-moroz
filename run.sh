#!/bin/sh

execServe="/usr/bin/moroz"

if [[ ! -z "${CONFIGS_DIR}" ]]; then
    echo "configs dir set in CONFIGS_DIR"
    execServe="${execServe} -configs ${CONFIGS_DIR}"
else
    execServe="${execServe} -configs /configs"
fi

if [[ ! -z "${EVENT_DIR}" ]]; then
    echo "event-dir set in env"
    execServe="${execServe} -event-dir ${EVENT_DIR}"
else
    execServe="${execServe} -event-dir /logs/events"
fi

if [[ ! -z "${TLS_CERT}" ]]; then
    echo "tls-cert set in env"
    echo "${TLS_CERT}" > /certs/server.crt
    execServe="${execServe} -tls-cert /certs/server.crt"
else
    if [[ -f "/certs/server.crt" ]]; then
        echo "using tls-cert found at /certs/server.crt"
        execServe="${execServe} -tls-cert /certs/server.crt"
    fi
fi

if [[ ! -z "${TLS_KEY}" ]]; then
    echo "tls-key set in env"
    echo "${TLS_KEY}" > /certs/server.key
    execServe="${execServe} -tls-key /certs/server.key"
else
    if [[ -f "/certs/server.key" ]]; then
        echo "using tls-key found at /certs/server.key"
        execServe="${execServe} -tls-key /certs/server.key"
    fi
fi

if [[ ! -z "${HTTP_ADDR}" ]]; then
    echo "http-addr set in env"
    execServe="${execServe} -http-addr=${HTTP_ADDR}"
else
    execServe="${execServe} -http-addr=:8080"
fi

if [[ ! -z "${DEBUG}" ]]; then
    echo "http-debug set in env"
    execServe="${execServe} -debug"
fi


if [[ ${USE_TLS} = "false" ]]; then
    echo "use-tls set to false in env"
    execServe="${execServe} -use-tls=false"
fi

echo "Starting using: $execServe"

eval $execServe
