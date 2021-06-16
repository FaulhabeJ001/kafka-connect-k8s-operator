helm uninstall test-connect-operator
kubectl delete ns kafka --ignore-not-found
kubectl delete pod busyboxplus --ignore-not-found

echo "success -> all resources for test deleted"