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

## Namespaces
kubectl apply -f namespace.yaml
kubectl get ns develop || kubectl create ns develop
kubectl get ns staging || kubectl create ns staging
kubectl get ns production || kubectl create ns production

## Role
kubectl create role deployment-editor --verb=set --resource=images
kubectl create rolebinding deployment-editor --serviceaccount=cd-jenkins -n production
kubectl create rolebinding deployment-editor --serviceaccount=cd-jenkins -n staging
kubectl create rolebinding deployment-editor --serviceaccount=cd-jenkins -n develop

## Deployment


## Keys
kubectl apply -f regcred.yaml

