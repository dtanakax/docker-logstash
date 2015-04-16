# Set the base image
FROM tanaka0323/java7

# File Author / Maintainer
MAINTAINER Daisuke Tanaka, tanaka@infocorpus.com

ENV DEBIAN_FRONTEND noninteractive
ENV LOGSTASH_VERSION 1.5.0.rc2

RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*
RUN apt-get clean all

# Download logstash
RUN curl -k https://download.elasticsearch.org/logstash/logstash/logstash-$LOGSTASH_VERSION.tar.gz >> logstash.tar.gz && \
    tar zxvf logstash.tar.gz && \
    mv -f /logstash-$LOGSTASH_VERSION /opt/logstash && \
    rm -f logstash.tar.gz

RUN mkdir -p /opt/certs && \
    mkdir -p /opt/conf

# Adding the configuration file
COPY logstash.conf /opt/conf/logstash.conf
COPY logstash-forwarder.key /opt/certs/logstash-forwarder.key
COPY logstash-forwarder.crt /opt/certs/logstash-forwarder.crt
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Install popular plugins
RUN /opt/logstash/bin/plugin install \
    logstash-input-kafka \
    logstash-input-lumberjack \
    logstash-output-influxdb \
    logstash-output-kafka

# Define mountable directories.
VOLUME ["/opt/conf", "/opt/certs"]

# Set the port
# 5000  syslog
# 5043 lumberjack
# 9292 logstash ui
EXPOSE 5000 5043 9292

# Executing sh
ENTRYPOINT ./start.sh