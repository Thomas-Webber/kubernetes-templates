#!/usr/bin/env bash

set -e

kubectl apply -f configMap.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml