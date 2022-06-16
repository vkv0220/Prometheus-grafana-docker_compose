You can install node_explorer by yourself or use script for install. For manual installing:

wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz
tar xvfz node_exporter-1.3.1.linux-amd64.tar.gz
mv node_exporter-1.3.1.linux-amd64 /opt/node_exporter
./node_exporter

vi /etc/node_exporter
OPTIONS=""

vi /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter

[Service]
EnvironmentFile=/etc/node_exporter
ExecStart=/opt/node_exporter/node_exporter $OPTIONS
[Install]
WantedBy=multi-user.target

systemctl status node_exporter
systemctl daemon-reload

systemctl start node_exporter && systemctl status node_exporter
systemctl enable node_exporter
