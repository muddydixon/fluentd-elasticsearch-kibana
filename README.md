fluentd x elasticsearch x kibana Dockerfile
-----

Docker image containing fluentd, elasticsearch, kibana.
You send message with fluentd with tag `es.*` to fluentd of this image.

## Requirement
* setup memory [elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#docker-cli-run-prod-mode)

## Default password
* kibana
    * kibana/changeme [elastic](https://www.elastic.co/guide/en/x-pack/current/setting-up-authentication.html#built-in-users)


## configure elasticsearch
* https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#docker-configuration-methods

## Easy use

```zsh
docker-compose up -d
```

### Version
* elasticsearch 5.4.0
* kibana 5.4.0
* td-agent2

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
* fluent-plugin-secure-forward
* fluent-plugin-forest
* fluent-plugin-mackerel

## Author
muddydixon
