fluentd x elasticsearch x kibana Dockerfile
-----

Docker image containing fluentd, elasticsearch, kibana.
You send message with fluentd with tag `es.*` to fluentd of this image.

## Easy use

```zsh
docker run -d --privileged  -p 5601:5601 -p 9200:9200 -p 24224:24224 muddydixon/fluentd-elasticsearch-kibana
```

Using your `td-agent.conf`

```zsh
docker run -d --privileged  -p 5601:5601 -p 9200:9200 -p 24224:24224 -v ${TD_AGENT_CONF_PATH}:/etc/td-agent/td-agent.conf muddydixon/fluentd-elasticsearch-kibana
```

`elasticsearch.yml` or `kibana.yml` are same:

* to `/etc/elasticsearch/elasticsearch.yml`
* to `/etc/kibana/kibana.yml`

### Version
* elasticsearch 5.X
* kibana 4.5
* td-agent2

## How to build

```zsh
% docker build --rm .
```

if you are required http_proxy

```zsh
% docker build --rm --build-arg http_proxy=${http_proxy} --build-arg https_proxy=${https_proxy} .
```

## How to run

```zsh
% docker run -d -p 9200:9200 -p 5601:5601 -p 24224:24224 muddydixon/fluentd-elasticsearch-kibana
```

## Try it

```zsh
% echo '{"val": 0.99}' | fluent-cat -p 24224 -h 192.168.99.100 es.hoge
```

## View kibana

```
% open http://192.168.99.100:5601
```

## Fluent plugins
* fluent-plugin-elasticsearch
* fluent-plugin-forest
* fluent-plugin-mackerel
* fluent-plugin-mysql-bulk

## License
Apache License Version 2.0

## Author
muddydixon
