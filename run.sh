#!/bin/bash

/usr/bin/moroz -configs /configs -event-logfile /logs/events -tls-cert /certs/server.crt -tls-key /certs/server.key -http-addr=:8080
