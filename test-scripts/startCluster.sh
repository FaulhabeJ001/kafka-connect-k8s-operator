
echo "create kafka-cluster"

kubectl apply -f ../kafka-deployment/kafka-cluster.yaml

kubectl wait --for=condition=ready --timeout=30s -n kafka pod/kafka

echo "success -> kafka-cluster started"