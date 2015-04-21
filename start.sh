#!/bin/bash
set -e

if [ "$1" = "/opt/logstash/bin/logstash" ]; then
    exec "$1" agent -f /opt/conf/logstash.conf
else
    exec "$@"
fi