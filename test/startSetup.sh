
kubectl apply -f ./kafka-cluster.yaml
kubectl wait --for=condition=ready --timeout=30s -n kafka pod/kafka
helm install test-connect-operator ../kafka-operator-helm --set baseurl=kafka.kafka.svc.cluster.local:8083

echo "success -> setup started"