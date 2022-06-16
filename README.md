# Prometheus-grafana-docker_compose
Prometheus, Grafana combined to docker-compose

### How to use
#### Clone repo to your destination
```git clone git@github.com:vkv0220/Prometheus-grafana-docker_compose.git```
#### Edit ip adresses in prometheus config file 

#### Build and run stack
```cd Prometheus-grafana-docker_compose && docker-compose up -d```

Docker compose services has restart: always directives, but you can use different ways to add to autostart this build to your system
You can choose how to add autostart stack depends on your system (example below for systemd systems):

```
#/etc/systemd/system/prometheus-grafana-docker-compose.service
[Unit]
Description=Docker Compose Application Service
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/opt/Prometheus-grafana-docker_compose
ExecStart=/usr/local/bin/docker-compose up -d
ExecStop=/usr/local/bin/docker-compose down
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
```

```systemctl daemon-reload && systemctl enable prometheus-grafana-docker-compose```

#### For metrics data you can use node_exporter. node_exporter dir contains node_exporter setup scripts for SysV or Systemd based systems.