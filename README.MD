# About modified kafka-connector

original-code: https://github.com/confluentinc/streaming-ops/tree/6ab71e1c4a8456fd9e0094422eb411fa514b9149/images/connect-operator)

Modifications:
- load_configs (operator.sh): write args from mounted volumes in tmp-file instead .properties file for getting rid of memory leak problems.

Usage:
* helm install \<installation-name\> kafka-operator-helm --set baseurl=\<kafka-connect-url\>
    * mandatory: installation-name = "kc-operator-\<spacename\>" (convention)
    * mandatory: --set baseurl=\<kafka-connect-url\> (url to kafka-connect-cluster (in space))
    * optional: --set id=\<alternative-id\> (default id is installation-name)

Testscenario:
* before tests: sh ./startSetup.sh
* tests (in ./test/)
    * sh ./startSetup.sh
    * busyboxplus for curl-tests
        * kubectl run -i --tty busyboxplus --image=radial/busyboxplus:curl --restart=Never -- /bin/sh
    * wait some minutes until DNS-Entries are added for kafka
        * check this with: curl kafka.kafka.svc.cluster.local:8083/connectors (in busyboxplus)
    * create connector-configs
        * kubectl apply -f ./test-data/connector-config-file-test1.yaml
        * kubectl apply -f ./test-data/connector-config-file-test2.yaml
    * check:
        * curl kafka.kafka.svc.cluster.local:8083/connectors (in busyboxplus)
    * delete connector-configs
        * kubectl delete -f ./test-data/connector-config-file-test1.yaml
        * kubectl delete -f ./test-data/connector-config-file-test2.yaml
    * check:
        * curl kafka.kafka.svc.cluster.local:8083/connectors (in busyboxplus)
* after tests: sh ./cleanup.sh

Helpful commands:
* kubectl logs kc-operator-test -n kc-operator-test
* kubectl exec kc-operator-test -i -t -n kc-operator-test -- /bin/bash
* kubectl run -i --tty busyboxplus --image=radial/busyboxplus:curl --restart=Never -- /bin/sh
* kubectl port-forward kafka 3030 -n kafka (Minikube: kafka-dashboard)