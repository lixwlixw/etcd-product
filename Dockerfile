FROM registry.dataos.io/datafoundry/coreos-etcd:latest
COPY /bash/etcd-join.sh /etcd-join.sh
COPY /bash/cluster_status.sh /cluster_status.sh
