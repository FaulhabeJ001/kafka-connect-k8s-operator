
echo "create serviceaccount"
kubectl create namespace kc-monitor-configmaps
kubectl create serviceaccount kc-monitor-configmaps-acc -n kc-monitor-configmaps
kubectl create clusterrole kc-monitor-configmaps --verb=get,watch,list --resource=configmaps
kubectl create clusterrolebinding kc-monitor-configmaps --clusterrole=kc-monitor-configmaps --serviceaccount=kc-monitor-configmaps:kc-monitor-configmaps-acc

echo "create kc-access-config"
kubectl apply -f ../kc-access-config.yaml

echo "create connect-operator"
kubectl apply -f ../connect-operator-pod.yaml

kubectl wait --for=condition=ready --timeout=30s -n kc-monitor-configmaps pod/connect-operator

echo "success -> connect-operator started"