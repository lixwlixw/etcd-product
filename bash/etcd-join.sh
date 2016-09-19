# $1 endpoints
# $2 newnode 
# $3 initial-advertise-peer-urls 
# $4 sb-instanceid-etcd
# $5 rootpasswd

#echo "----->join" $2 "into" $1 "with" $3  "use id " $4

export ETCDCTL_ENDPOINT=$1

#echo "----->remove $3"
#tmpnode=`etcdctl -u root:$5 member list |grep $3|awk -F ':' '{print $1}'|awk -F '[' '{print $1}' `
#echo "remove nodeid:" $tmpnode
#etcdctl -u root:$5 member remove $tmpnode

#echo "----->add $2 $3"
#eval `etcdctl -u root:$5 member add  $3 | grep ETCD_INITIAL_CLUSTER`
export ETCD_INITIAL_CLUSTER_STATE=existing
export ETCD_NAME=$2

echo "----->start etcd"
echo "ETCD_INITIAL_CLUSTER:" $ETCD_INITIAL_CLUSTER
etcd -initial-cluster sb-etcd-test-etcd1=http://sb-etcd-test-etcd1:2380,sb-etcd-test-etcd2=http://sb-etcd-test-etcd2:2380,sb-etcd-test-etcd3=http://sb-etcd-test-etcd3:2380 -initial-cluster-token sb-etcd-test-etcd -initial-advertise-peer-urls $3 -listen-peer-urls http://0.0.0.0:2380 -listen-client-urls http://127.0.0.1:2379 -advertise-client-urls $1 

