#bind的时候添加一个能read write所有节点的用户
#$1 username
#$2 password
#$3 rootpassword
etcdctl -u root:$3 user add $1 << EOF
$2
EOF

etcdctl -u root:$3  user grant $1 -roles binduser 

#又有一个bug，必须再passwd一次
etcdctl -u root:$3 user passwd $1 << EOF
$2
EOF