FROM openjdk:11-jdk-slim

ENV SCALA_VERSION=2.12
ENV KAFKA_VERSION 3.2.3

RUN set -ex; \
  apt-get update; \
  apt-get -y install gettext-base telnet jq wget; \
  apt-get clean; \
  rm -rf /var/lib/apt/lists/*

ENV KAFKA_HOME=/opt/kafka
ENV PATH=$KAFKA_HOME/bin:$PATH

RUN groupadd --system --gid=9999 kafka && \
    useradd --system --home-dir $KAFKA_HOME --uid=9999 --gid=kafka kafka

WORKDIR $KAFKA_HOME

ARG KAFKA_ARCHIVE=https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz
RUN set -ex; \
    mkdir -p /data/kraft && chown kafka:kafka /data/kraft; \ 
    wget -nv -O kafka.tgz "${KAFKA_ARCHIVE}"; \
    tar -xvzf kafka.tgz --strip-components=1; \
    rm kafka.tgz; \
    chown -R kafka:kafka .

COPY --chown=kafka:kafka ./server.tpl.properties ./config/kraft/server.tpl.properties
COPY --chown=kafka:kafka ./generate_properties.sh ./generate_properties.sh
COPY --chown=kafka:kafka ./entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh && chmod +x ./generate_properties.sh

EXPOSE 9092
USER kafka
ENTRYPOINT ["./entrypoint.sh"]