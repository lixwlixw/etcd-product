#!/bin/sh
#echo "detect etcd cluster status"
cluster_status=$(etcdctl cluster-health | tail -n 1 | awk '{print $3}')
#echo "etcd cluster stuats: "$cluster_status

if [ "$cluster_status"x = "unhealthy"x ]; then
sed -i s#etcd -initial-cluster etcd2=http://etcd-2:2380,etcd1=http://etcd-1:2380,etcd3=http://etcd-3:2380 -initial-cluster-token sb-etcd-test-etcd -initial-advertise-peer-urls $3 -listen-peer-urls http://0.0.0.0:2380 -listen-client-urls http://0.0.0.0:2379 -advertise-client-urls $1 -initial-cluster-state $6#etcd -initial-advertise-peer-urls $3 -listen-peer-urls http://0.0.0.0:2380 -listen-client-urls http://0.0.0.0:2379 -advertise-client-urls $1#g /etcd-join.sh
exit1
fi

#curl $2
