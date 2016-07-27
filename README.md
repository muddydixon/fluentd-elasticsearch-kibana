fluentd x elasticsearch x kibana Dockerfile
-----

## How to build

```zsh
% docker build --rm -t fek .
```

if you are required http_proxy

```zsh
% docker build --rm --build-arg http_proxy=${http_proxy} --build-arg https_proxy=${https_proxy} -t fek .
```

## How to run

```zsh
% docker run -d -p 9200:9200 -p 5601:5601 -p 24224:24224 fek
```

## Try it

```zsh
% echo '{"val": 0.99}' | fluent-cat -p 24224 -h 192.168.99.100 es.hoge
```

## View kibana

```
% open http://192.168.99.100:5601
```
