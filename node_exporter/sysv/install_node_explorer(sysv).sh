#!/bin/bash
set -ex
wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz
tar xvfz node_exporter-1.3.1.linux-amd64.tar.gz
mv node_exporter-1.3.1.linux-amd64 /opt/node_exporter

cat <<EOF > /etc/init.d/node_exporter
#!/bin/bash

NAME=node_exporter
PIDFILE=/var/run/$NAME.pid

service_name="node_exporter"

start() {
 echo "Starting node_exporter..."
 PID=`/opt/node_exporter/node_exporter > /dev/null 2>&1 & echo $!`
 if [ -z $PID ]; then
   printf "%s\n" "Fail"
 else
   echo $PID > $PIDFILE
   printf "%s\n" "Ok"
 fi

}
stop() {
 echo "Stopping node_exporter..."
 PID=`cat /var/run/$NAME.pid`
 if [ -f $PIDFILE ]; then
   kill -HUP $PID
   printf "%s\n" "Ok"
   rm -f $PIDFILE
 else
   printf "%s\n" "pidfile not found"
 fi

}
status() {
 if (( $(ps -ef | grep -v grep | grep $service_name | wc -l) > 0 )); then
  echo "$service_name is running!!!"
 else
  echo "$service_name is down!!!"
 fi
}
case $1 in
  start|stop|status) $1;;
  restart) stop; start;;
  *) echo "Usage : $0 <start|stop|restart>"; exit 1;;
esac
EOF


/etc/init.d/node_exporter start
/etc/init.d/node_exporter status
rc-update add node_exporter default
