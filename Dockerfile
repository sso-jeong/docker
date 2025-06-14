FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    wget curl gnupg openjdk-11-jdk unzip net-tools supervisor && \
    apt-get clean

ENV KAFKA_VERSION=3.7.0
ENV SCALA_VERSION=2.13
ENV KAFKA_HOME=/opt/kafka

RUN mkdir -p ${KAFKA_HOME} && \
    wget https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -O /tmp/kafka.tgz && \
    tar -xzf /tmp/kafka.tgz --strip=1 -C ${KAFKA_HOME} && \
    rm /tmp/kafka.tgz

# ✅ Kafka 로그 디렉토리 생성 및 권한 부여
RUN mkdir -p /opt/kafka/logs && chmod -R 777 /opt/kafka

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 2181 9092 9094

CMD ["/start.sh"]
