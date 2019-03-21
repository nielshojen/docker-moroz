#!/bin/sh

echo ">>> Starting Moroz Server <<<"

execServe="/usr/bin/moroz"

if [[ ! -z "${CONFIGS_DIR}" ]]; then
    execServe="${execServe} -configs ${CONFIGS_DIR}"
else
    execServe="${execServe} -configs /configs"
fi

if [[ ! -z "${EVENT_LOGFILE}" ]]; then
    execServe="${execServe} -event-logfile ${EVENT_LOGFILE}"
else
    execServe="${execServe} -event-logfile /logs/events"
fi

if [[ ! -z "${TLS_CERT}" ]]; then
    echo "TLS_CERT Set"
    echo "${TLS_CERT}" > /certs/server.crt
    execServe="${execServe} -tls-cert /certs/server.crt"
else
    if [[ -f "/certs/server.crt" ]]; then
        execServe="${execServe} -tls-cert /certs/server.crt"
    fi
fi

if [[ ! -z "${TLS_KEY}" ]]; then
    echo "TLS_KEY Set"
    echo "${TLS_KEY}" > /certs/server.key
    execServe="${execServe} -tls-key /certs/server.key"
else
    if [[ -f "/certs/server.key" ]]; then
        execServe="${execServe} -tls-key /certs/server.key"
    fi
fi

if [[ ! -z "${HTTP_ADDR}" ]]; then
    execServe="${execServe} -http-addr=${HTTP_ADDR}"
else
    execServe="${execServe} -http-addr=:8080"
fi

echo "Starting using: $execServe"

eval $execServe
