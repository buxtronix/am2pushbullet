Prometheus Alertmanager -> Pushbullet gateway
=====

A simple gateway that takes alert messages from [Prometheus Alertmanager](https://prometheus.io/docs/alerting/alertmanager/)
via the [webhook receiver](https://prometheus.io/docs/alerting/configuration/#webhook_config),
and forwards them to [Pushbullet](http://pushbullet.com/).

No templating or fancy features for now, but these may be included in due course,
perhaps also export metrics for alerts sent (and maybe Pushbullet's token allowance
left).

Usage
===

Configure as a webhook endpoint in alertmanager.yml:

```
- name: 'default-receiver'
  webhook_configs:
  - url: http://127.0.0.1:5001/alerts
```

Set the host/port in the URL to match where this gateway is running.

Build the gateway:

```
$ go get github.com/prometheus/alertmanager/template
$ go get github.com/xconstruct/go-pushbullet
$ go build am2pushbullet.go
```

Run the gateway with at least the API key flag, use your [API key](https://www.pushbullet.com/#settings):

```
$ ./am2pushbullet -api_key o.sdf923456fs765dfsfsdf
```

That's it!

Do note that Pushbullet limits pushed from free accounts to 500/month.

Licence
===

MIT.

