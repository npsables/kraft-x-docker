#!/bin/bash

export KAFKA_HOME=${KAFKA_HOME:-/opt/kafka}

default_id=1
default_controller_port=9093
export KAFKA_ROLES=${KAFKA_ROLES:-broker,controller}
export KAFKA_ID=${KAFKA_ID:-$default_id}
export KAFKA_QUORUM_VOTERS=${KAFKA_QUORUM_VOTERS:-${default_id}@localhost:${default_controller_port}}

#listener
export KAFKA_LISTENER_NAME=${KAFKA_LISTENER_NAME:-PLAINTEXT}
export KAFKA_LISTENER_IP=${KAFKA_LISTENER_IP:-localhost}
export KAFKA_LISTENER_PORT=${KAFKA_LISTENER_PORT:-9290}

# controller
export KAFKA_CONTROLLER_NAME=${KAFKA_CONTROLLER_NAME:-CONTROLLER}
export KAFKA_CONTROLLER_PORT=${KAFKA_CONTROLLER_PORT:-${default_controller_port}}

# docker external
export DOCKER_EXTERNAL_NAME=${DOCKER_EXTERNAL_NAME:-EXTERNAL}
export DOCKER_EXTERNAL_IP=${DOCKER_EXTERNAL_IP:-localhost}
export DOCKER_EXTERNAL_PORT=${DOCKER_EXTERNAL_PORT:-9092}

# others
export KAFKA_LOG_DIR=/data/kraft # how to allow create new file here if not root???
export KAFKA_DEFAULT_NUM_PARTITIONS=${KAFKA_DEFAULT_NUM_PARTITIONS:-1}
export KAFKA_THREAD_PER_DIR=${KAFKA_THREAD_PER_DIR:-1}
export KAFKA_META_REPLICATION_FACTOR=${KAFKA_META_REPLICATION_FACTOR:-1}
export KAFKA_RETENTION=${KAFKA_RETENTION:-168}


envsubst < "${KAFKA_HOME}/config/kraft/server.tpl.properties" > "${KAFKA_HOME}/config/kraft/server.properties"