#!/bin/sh

execServe="/usr/bin/moroz"

if [[ ${CONFIGS_DIR} ]]; then
    execServe="${execServe} -configs ${CONFIGS_DIR}"
else
    execServe="${execServe} -configs /configs"
fi

if [[ ${EVENT_LOGFILE} ]]; then
    execServe="${execServe} -event-logfile ${EVENT_LOGFILE}"
else
    execServe="${execServe} -event-logfile /logs/events"
fi

if [[ ${TLS_CERT} ]]; then
    echo ${TLS_CERT} > /certs/server.crt
    execServe="${execServe} -tls-cert ${TLS_CERT}"
else
    if [[ -f "/certs/server.crt" ]]; then
        execServe="${execServe} -tls-cert /certs/server.crt"
    fi
fi

if [[ ${TLS_KEY} ]]; then
    echo ${TLS_KEY} > /certs/server.key
    execServe="${execServe} -tls-key ${TLS_KEY}"
else
    if [[ -f "/certs/server.crt" ]]; then
        execServe="${execServe} -tls-key /certs/server.key"
    fi
fi

if [[ ${HTTP_ADDR} ]]; then
    execServe="${execServe} -http-addr=${HTTP_ADDR}"
else
    execServe="${execServe} -http-addr=:8080"
fi

if [[ ${USE_TLS} = "false" ]]; then
    execServe="${execServe} -http-addr=${HTTP_ADDR}"
else
    execServe="${execServe} -use-tls false"
fi

echo "Starting using: $execServe"

eval $execServe
