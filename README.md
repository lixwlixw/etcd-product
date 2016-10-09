#三个RC 四个SVC 一个route 一个初始化集群root密码pod 的 ETCD集群

- oc new-build https://github.com/lixwlixw/etcd-product.git
- oc create -f dc-all.yaml (提前创建好PV PVC)
- oc create -f svc-all.yaml
- oc create -f route.yaml
- oc create -f pod.yaml

