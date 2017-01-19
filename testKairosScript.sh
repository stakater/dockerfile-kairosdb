#!/bin/bash

export PORT_TELNET=${PORT_TELNET:-4242}
export PORT_HTTP=${PORT_HTTP:-8080}
export CASS_HOSTS=${CASS_HOSTS:-"localhost:9160"}
export REPFACTOR=${REPFACTOR:-1}
export HEALTH_RESPONSE_CODE=${HEALTH_RESPONSE_CODE:-200}

function main {
  echo "- env ------------------------------------------------------------------"
  env | sort
  echo "------------------------------------------------------------------------"
  echo "- kairosdb.properties --------------------------------------------------"
  envsubst < kairosdb.properties > kairosdb_new.properties
  cat kairosdb_new.properties
  echo "------------------------------------------------------------------------"
#  /opt/kairosdb/bin/kairosdb.sh run
}

main "$@"
