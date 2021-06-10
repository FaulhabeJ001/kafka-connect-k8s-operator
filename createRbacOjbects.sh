kubectl delete ns kc-monitor-configmaps
kubectl delete clusterrole kc-monitor-configmaps
kubectl delete clusterrolebinding kc-monitor-configmaps

kubectl create namespace kc-monitor-configmaps
kubectl create serviceaccount kc-monitor-configmaps-acc --namespace kc-monitor-configmaps
kubectl create clusterrole kc-monitor-configmaps --verb=get,watch,list --resource=configmaps
kubectl create clusterrolebinding kc-monitor-configmaps --clusterrole=kc-monitor-configmaps --serviceaccount=kc-monitor-configmaps:kc-monitor-configmaps-acc

kubectl apply -f kc-access-config.yaml
kubectl apply -f connect-operator-pod.yaml

kubectl apply -f kafka-deployment/kafka-namespace.yaml
kubectl apply -f kafka-deployment/kafka-cluster.yaml