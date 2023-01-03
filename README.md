Prometheus Alertmanager -> Pushbullet gateway
=====

A simple gateway that takes alert messages from [Prometheus Alertmanager](https://prometheus.io/docs/alerting/alertmanager/)
via the [webhook receiver](https://prometheus.io/docs/alerting/configuration/#webhook_config),
and forwards them to [Pushbullet](http://pushbullet.com/).

No templating or fancy features for now, but these may be included in due course,
perhaps also export metrics for alerts sent (and maybe Pushbullet's token allowance
left).

## Usage

Do note that Pushbullet limits pushed from free accounts to 500/month.

### Docker

You'll probably be deploying Alertmanager as part of a docker-compose stack, add the following in your stack:

```yaml
version: '2.1'
services:
 ...
 pushbullet-gateway:
    image: buxtronix/am2pushbullet:latest
    container_name: pushbullet-gateway
    restart: unless-stopped
    environment:
      - PUSHBULLET_KEY=<you Pushbullet API key>
    expose:
      - 5001
```

Then, configure it as a webhook endpoint in alertmanager.yml:

```yaml
- name: 'default-receiver'
  webhook_configs:
  - url: http://pushbullet-gateway:5001/alert
```

That's it!

### Compile yourself

Configure as a webhook endpoint in alertmanager.yml:

```yaml
- name: 'default-receiver'
  webhook_configs:
  - url: http://127.0.0.1:5001/alert
```

Set the host/port in the URL to match where this gateway is running.

Build the gateway:

```console
$ go get github.com/prometheus/alertmanager/template
$ go get github.com/xconstruct/go-pushbullet
$ go build am2pushbullet.go
```

Run the gateway with at least the API key flag, use your [API key](https://www.pushbullet.com/#settings):

```console
$ ./am2pushbullet -api_key o.sdf923456fs765dfsfsdf
```

That's it!

Licence
===

MIT.

