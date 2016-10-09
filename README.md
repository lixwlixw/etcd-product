#ETCD

- oc new-build https://github.com/lixwlixw/etcd-product.git
- oc create -f dc-all.yaml (提前创建好PV PVC)
- oc create -f svc-all.yaml
- oc create -f route.yaml
- oc create -f pod.yaml

