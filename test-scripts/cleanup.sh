kubectl delete ns kafka --ignore-not-found

kubectl delete ns kc-monitor-configmaps --ignore-not-found
kubectl delete clusterrole kc-monitor-configmaps --ignore-not-found
kubectl delete clusterrolebinding kc-monitor-configmaps --ignore-not-found

kubectl delete pod busyboxplus --ignore-not-found

echo "success -> all resources for kafka-connect-k8s-operator deleted"