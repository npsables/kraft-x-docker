#!/bin/sh
$KAFKA_HOME/generate_properties.sh
$KAFKA_HOME/bin/kafka-storage.sh format -t $($KAFKA_HOME/bin/kafka-storage.sh random-uuid) -c $KAFKA_HOME/config/kraft/server.properties
$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/kraft/server.properties
