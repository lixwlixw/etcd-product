#创建root用户密码，并回收guest权限，添加bind用户权限
# $1 rootpassword
#!/bin/bash
sleep 300
etcdctl --endpoints $2 user add root << EOF
$1
EOF

etcdctl --endpoints $2 auth enable

etcdctl --endpoints $2 -u root:$1 role revoke guest --path '/*' -readwrite

etcdctl --endpoints $2 -u root:$1 role add binduser

etcdctl --endpoints $2 -u root:$1 role grant binduser -path '/*' -readwrite
