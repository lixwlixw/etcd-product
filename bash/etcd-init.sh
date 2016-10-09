export ETCDCTL_ENDPOINT=$3
member_count=$(etcdctl -u root:$1 member list |wc -l)
echo cluster_member_count: $member_count
if [ $member_count == 0 ];then
     echo "init new etct cluster"
    etcd -name \
     $7 \
     -initial-advertise-peer-urls \
     $2 \
     -listen-peer-urls \
     http://0.0.0.0:2380 \
     -listen-client-urls \
     http://0.0.0.0:2379 \
     -advertise-client-urls \
     $3 \
     -initial-cluster-token \
     $4 \
     -initial-cluster \
     $7=$2 \
     -initial-cluster-state \
     new
    etcdctl user add root << EOF
    $1
EOF

    etcdctl auth enable

    etcdctl -u root:$1 role revoke guest --path '/*' -readwrite

    etcdctl -u root:$1 role add binduser

    etcdctl -u root:$1 role grant binduser -path '/*' -readwrite

    etcdctl -u root:$1 user add $5 << EOF
    $6
EOF

    etcdctl -u root:$1 user grant $5 -roles binduser

    etcdctl -u root:$1 user passwd $5 << EOF
    $6
EOF
else
    echo "join exist etct cluster"
    export ETCDCTL_ENDPOINT=$3

    echo "----->remove $2"
    etcdctl -u root:$1 member list
    tmpnode=`etcdctl -u root:$1 member list |grep $2|awk -F ':' '{print $1}'|awk -F '[' '{print $1}' ` 
    echo "node removed:" $tmpnode
    etcdctl -u root:$1 member remove $tmpnode

    echo "----->add $2 $3"
    eval `etcdctl -u root:$1 member add $7 $2 | grep ETCD_INITIAL_CLUSTER`
    export ETCD_INITIAL_CLUSTER_STATE=existing
    export ETCD_NAME=$7
    etcdctl -u root:$1 member list

    echo "----->start etcd"
    echo ETCD_INITIAL_CLUSTER:"$ETCD_INITIAL_CLUSTER"
    etcd -initial-cluster $ETCD_INITIAL_CLUSTER -initial-cluster-token $4 -initial-advertise-peer-urls $2 -listen-peer-urls http://0.0.0.0:2380 -listen-client-urls http://0.0.0.0:2379 -advertise-client-urls $3
fi

