#!/usr/bin/env bash

## Helm 2
wget https://get.helm.sh/helm-v2.16.0-linux-amd64.tar.gz -O helm-v2.tar.gz
tar -xvzf helm-v2.tar.gz
sudo cp linux-amd64/helm /usr/local/bin/helm2
helm2 init --wait

## Helm 3
wget https://get.helm.sh/helm-v3.0.0-rc.3-linux-amd64.tar.gz -O helm-v3.tar.gz
tar -xvzf helm-v2.tar.gz
sudo cp linux-amd64/helm /usr/local/bin
helm repo add stable https://kubernetes-charts.storage.googleapis.com/

## Namespaces
kubectl apply -f namespace.yaml
kubectl get ns develop || kubectl create ns develop
kubectl get ns staging || kubectl create ns staging
kubectl get ns production || kubectl create ns production

## Role
kubectl apply -f jenkins/serviceaccount.yaml
kubectl create role deployment-editor --verb=set --resource=images
kubectl create rolebinding deployment-editor --serviceaccount=cd-jenkins -n production
kubectl create rolebinding deployment-editor --serviceaccount=cd-jenkins -n staging
kubectl create rolebinding deployment-editor --serviceaccount=cd-jenkins -n develop

## Docker registry
helm2 install stable/docker-registry -f registry.conf.yaml --name docker-registry --namespace ci
kubectl apply -f docker/frontend.deployment.yaml
kubectl apply -f docker/frontend.service.yaml
#kubectl proxy # http://127.0.0.1:8001/api/v1/namespaces/ci/services/docker-registry-fe/proxy
kubectl apply -f docker/regcred.yaml

## Jenkins
kubectl config set-context minikube --namespace=ci
helm install jenkins stable/jenkins -f jenkins/jenkins.conf.yaml
kubectl --namespace ci port-forward jenkins 8080:8080



