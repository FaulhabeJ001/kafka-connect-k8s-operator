# About modified kafka-connector

original-code: https://github.com/confluentinc/streaming-ops/tree/6ab71e1c4a8456fd9e0094422eb411fa514b9149/images/connect-operator)

Modifications:
- load_configs (operator.sh): write args from mounted volumes in tmp-file instead .properties file for getting rid of memory leak problems.

Testscenario:
* start pod with kafka-cluster: 
    * kubectl apply -f kafka-cluster.yaml
* start connect-operator
    * create service-account
        * kubectl create namespace kc-monitor-configmaps
        * kubectl create serviceaccount kc-monitor-configmaps-acc --namespace kc-monitor-configmaps
        * kubectl create clusterrole kc-monitor-configmaps --verb=get,watch,list --resource=configmaps
        * kubectl create clusterrolebinding kc-monitor-configmaps --clusterrole=kc-monitor-configmaps --serviceaccount=kc-monitor-configmaps:kc-monitor-configmaps-acc
    * create access-config (ConfigMap, modify if needed)
        * kubectl apply -f kc-access-config.yaml
    * create connect-operator (modify env-variables if needed)
        * kubectl apply -f connect-operator-pod.yaml -n example-monitor-configmaps
* tests
    * curling the connect-rest-api with:
        * kubectl run -i --tty busyboxplus --image=radial/busyboxplus:curl --restart=Never -- /bin/sh
    * create connector-configs
        * kubectl apply -f connector-config-file-test1.yaml
        * kubectl apply -f connector-config-file-test2.yaml
    * check:
        * curl kafka.kafka.svc.cluster.local:8083/connectors
        * kubectl logs connect-operator -n example-monitor-configmaps
    * delete connector-configs
        * kubectl delete -f connectzor-config-file-test1.yaml
        * kubectl delete -f connectzor-config-file-test2.yaml
    * check:
        * curl kafka.kafka.svc.cluster.local:8083/connectors
        * kubectl logs connect-operator -n example-monitor-configmaps


Helpful commands:
* k delete po -n example-monitor-configmaps connect-operator
* k apply -f connect-operator-pod.yaml -n example-monitor-configmaps
* k logs connect-operator -n example-monitor-configmaps
* k describe po connect-operator -n example-monitor-configmaps
* k exec connect-operator -i -t -n example-monitor-configmaps -- /bin/bash
* k run -i --tty busyboxplus --image=radial/busyboxplus:curl --restart=Never -- /bin/sh
* k port-forward kafka 3030 -n kafka (Minikube -> kafka-dashboard)