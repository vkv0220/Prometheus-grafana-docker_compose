#!/bin/bash
set -ex
wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz
tar xvfz node_exporter-1.3.1.linux-amd64.tar.gz
mv node_exporter-1.3.1.linux-amd64 /opt/node_exporter

cat <<EOF > /etc/node_exporter
OPTIONS=""
EOF

cat <<EOF > /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter

[Service]
EnvironmentFile=/etc/node_exporter
ExecStart=/opt/node_exporter/node_exporter $OPTIONS

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload && systemctl enable node_exporter
systemctl start node_exporter && systemctl status node_exporter
