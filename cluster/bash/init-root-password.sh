#创建root用户密码，并回收guest权限，添加bind用户权限
# $1 rootpassword

etcdctl user add root << EOF
$1
EOF

etcdctl auth enable

etcdctl -u root:$1 role revoke guest --path '/*' -readwrite

etcdctl -u root:$1 role add binduser

etcdctl -u root:$1 role grant binduser -path '/*' -readwrite