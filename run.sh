#!/bin/sh

echo ">>> Starting Moroz Server <<<"

execServe="/usr/bin/moroz"

if [[ ! -z "${CONFIGS_DIR}" ]]; then
    echo "configs dir set in CONFIGS_DIR"
    execServe="${execServe} -configs ${CONFIGS_DIR}"
else
    execServe="${execServe} -configs /configs"
fi

if [[ ! -z "${EVENT_LOGFILE}" ]]; then
    echo "event-logfile set in env"
    execServe="${execServe} -event-logfile ${EVENT_LOGFILE}"
else
    execServe="${execServe} -event-logfile /logs/events"
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

echo "Starting using: $execServe"

eval $execServe
