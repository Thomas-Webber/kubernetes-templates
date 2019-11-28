#!/bin/bash

# backend
helm2 install stable/docker-registry -f registry.conf.yaml --name docker-registry --namespace ci

# frontend
kubectl apply -f frontend.deployment.yaml
kubectl apply -f frontend.service.yaml
kubectl proxy # http://127.0.0.1:8001/api/v1/namespaces/ci/services/docker-registry-fe/proxy



