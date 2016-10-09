#创建root用户密码，并回收guest权限，添加bind用户权限
# $1 rootpassword
#!/bin/bash
while true
do
    hh=$(etcdctl --endpoints $2 -u root:$1 cluster-health | tail -1|awk '{print $3}')                        
    if [ h"$hh" = h"healthy" ]
        then              
                etcdctl --endpoints $2 user add root << EOF
$1                  
EOF                 
                etcdctl --endpoints $2 auth enable
                etcdctl --endpoints $2 -u root:$1 role revoke guest --path '/*' -readwrite
                etcdctl --endpoints $2 -u root:$1 role add binduser
                etcdctl --endpoints $2 -u root:$1 role grant binduser -path '/*' -readwrite
                exit                                                       
    fi                                                                     
done
