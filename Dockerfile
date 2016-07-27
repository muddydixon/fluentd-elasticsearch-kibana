FROM ubuntu

ARG HTTP_PROXY=${http_proxy}
ARG HTTPS_PROXY=${https_proxy}

ENV http_proxy=${HTTP_PROXY}
ENV https_proxy=${HTTPS_PROXY}

RUN apt-get update
RUN apt-get install -y wget curl openjdk-8-jdk
RUN wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb http://packages.elastic.co/elasticsearch/2.x/debian stable main" | tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list
RUN echo "deb http://packages.elastic.co/kibana/4.5/debian stable main" | tee -a /etc/apt/sources.list.d/kibana.list
RUN apt-get update
RUN apt-get install elasticsearch
RUN apt-get install kibana

RUN curl -L https://toolbelt.treasuredata.com/sh/install-ubuntu-xenial-td-agent2.sh | sed -e 's/sudo -k//' | sed -e 's/sudo //g' | sh
RUN td-agent-gem install fluent-plugin-elasticsearch

RUN echo '<source>\n  @type forward\n  port 24224\n  0.0.0.0\n</source>\n<match es.**.*>\n  @type elasticsearch\n  host localhost\n  port 9200\n  index_name es\n  include_tag_key true\n  tag_key @log_name\n  logstash_format true\n flus_interval 3s\n</match>' > /etc/td-agent/td-agent.conf

RUN echo 'service td-agent start\n\/etc/init.d/elasticsearch start\n\/opt/kibana/bin/kibana' >> /tmp/start.sh
RUN chmod +x /tmp/start.sh

EXPOSE 5601
EXPOSE 9200
EXPOSE 24224

ENTRYPOINT /tmp/start.sh
