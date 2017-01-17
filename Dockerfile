FROM openjdk:8-jre

MAINTAINER Brian Toal <brian.toal@gmail.com>

ARG BIN_VERSION=zookeeper-3.4.9

RUN apt-get install -y wget tar
RUN wget -q -N http://mirror.dkd.de/apache/zookeeper/$BIN_VERSION/$BIN_VERSION.tar.gz
RUN tar -zxvf ${BIN_VERSION}.tar.gz
RUN cp ${BIN_VERSION}/conf/zoo_sample.cfg ${BIN_VERSION}/conf/zoo.cfg
RUN echo "server.1=zk-1:2222:2223" >> ${BIN_VERSION}/conf/zoo.cfg
RUN echo "server.2=zk-2:2222:2223" >> ${BIN_VERSION}/conf/zoo.cfg
RUN echo "server.3=zk-3:2222:2223" >> ${BIN_VERSION}/conf/zoo.cfg
RUN mkdir /tmp/zookeeper

EXPOSE 2181 2222 2223

WORKDIR ${BIN_VERSION}/bin

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
