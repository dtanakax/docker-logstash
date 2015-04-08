#!/bin/bash
set -e

# Executing
exec /opt/logstash/bin/logstash agent -f /opt/conf/logstash.conf