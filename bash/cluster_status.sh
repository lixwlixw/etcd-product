#!/bin/sh
#echo "detect etcd cluster status"
cluster_status=$(etcdctl -u root:$1 cluster-health | tail -n 1 | awk '{print $3}')
#echo "etcd cluster stuats: "$cluster_status

if [ "$cluster_status"x = "unhealthy"x ]; then
exit 1
fi

#curl $2
