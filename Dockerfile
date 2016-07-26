FROM ubuntu

RUN apt-get update
RUN apt-get install -y wget curl openjdk-8-jdk
RUN wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb http://packages.elastic.co/elasticsearch/2.x/debian stable main" | tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list
RUN echo "deb http://packages.elastic.co/kibana/4.5/debian stable main" | tee -a /etc/apt/sources.list.d/kibana.list
RUN apt-get update
RUN apt-get install elasticsearch
RUN /usr/share/elasticsearch/bin/plugin install license
RUN /usr/share/elasticsearch/bin/plugin install graph

RUN apt-get install kibana
RUN /opt/kibana/bin/kibana plugin --install elasticsearch/graph/latest
# /etc/init.d/elasticsearch start\n\
# /etc/init.d/kibana start' >> /tmp/start.sh
# RUN chmod +x /tmp/start.sh
# ENTRYPOINT /tmp/start.sh

EXPOSE 5601
EXPOSE 9200
