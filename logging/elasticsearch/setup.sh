#!/usr/bin/env bash

set -e

kubectl apply -f configmap.yaml
kubectl apply -f statefulset.yaml
kubectl apply -f service.yaml

### Check elasticsearch node
kubectl port-forward es-cluster-0 9200:9200 --namespace=kube-logging
curl http://localhost:9200/_cluster/state?pretty
