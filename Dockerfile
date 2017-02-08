# Dockerfile to run KairosDB on Cassandra. Configuration is done through environment variables.
#
# The following environment variables can be set
#
#     $CASS_HOSTS           [kairosdb.datastore.cassandra.host_list] (default: localhost:9160)
#                           Cassandra seed nodes (host:port,host:port)
#
#     $REPFACTOR            [kairosdb.datastore.cassandra.replication_factor] (default: 1)
#                           Desired replication factor in Cassandra
#
#     $PORT_TELNET          [kairosdb.telnetserver.port] (default: 4242)
#                           Port to bind for telnet server
#
#     $PORT_HTTP            [kairosdb.jetty.port] (default: 8080)
#                           Port to bind for http server
#
# Sample Usage:
#                  docker run -P -e "CASS_HOSTS=192.168.1.63:9160" -e "REPFACTOR=1" stakater/kairosdb

FROM                stakater/java8-alpine

MAINTAINER          Rasheed Amir <rasheed@aurorasolutions.io>

ARG                 KAIROSDB_VERSION

RUN                 apk add --update --no-cache bash gawk sed grep bc coreutils gettext curl && rm -rf /var/cache/apk/*
RUN                 sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd

# Install Kairosdb
RUN                 wget https://github.com/kairosdb/kairosdb/releases/download/v${KAIROSDB_VERSION}/kairosdb-${KAIROSDB_VERSION}-1.tar.gz
RUN                 tar -xzf kairosdb-${KAIROSDB_VERSION}-1.tar.gz -C /opt \
                    && chown -R root:root /opt/kairosdb

ADD                 kairosdb.properties /tmp/kairosdb.properties
ADD                 runKairos.sh /usr/bin/run_kairos.sh

RUN                 chmod +x /usr/bin/run_kairos.sh

# Kairos ports
EXPOSE              8080
EXPOSE              4242

# Run kairosdb in foreground on boot
CMD                [ "/usr/bin/run_kairos.sh" ]
