FROM ubuntu:16.10

MAINTAINER muddydixon

ARG HTTP_PROXY=${http_proxy}
ARG HTTPS_PROXY=${https_proxy}

ENV http_proxy=${HTTP_PROXY}
ENV https_proxy=${HTTPS_PROXY}

RUN apt-get update
RUN apt-get install -y wget curl make g++ apt-transport-https libmysqlclient-dev openjdk-8-jdk
RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | tee -a /etc/apt/sources.list.d/elasticsearch-5.x.list
RUN echo "deb http://packages.elastic.co/kibana/4.5/debian stable main" | tee -a /etc/apt/sources.list.d/kibana.list
RUN apt-get update
RUN apt-get install elasticsearch kibana

RUN curl -L https://toolbelt.treasuredata.com/sh/install-ubuntu-xenial-td-agent2.sh | sed -e 's/sudo -k//' | sed -e 's/sudo //g' | sh
RUN td-agent-gem install fluent-plugin-elasticsearch
RUN td-agent-gem install fluent-plugin-forest
RUN td-agent-gem install fluent-plugin-mackerel
RUN td-agent-gem install fluent-plugin-mysql-bulk

RUN echo "vm.max_map_count=262144" >> /etc/sysctl.conf
RUN sysctl -p

ENV ES_JAVA_OPTS="-Xms1g -Xmx1g"

COPY ./td-agent.conf /etc/td-agent/td-agent.conf
COPY ./elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
COPY ./kibana.yml /etc/kibana/kibana.yml
COPY ./template.json /tmp/template.json
COPY ./start.sh /tmp/start.sh

EXPOSE 5601
EXPOSE 9200
EXPOSE 24224

ENTRYPOINT /tmp/start.sh
