#!/usr/bin/env bash

set -e

### Create private key and csr for user
openssl genrsa -out alice.key 2048
openssl req -new -key alice.key -subj="/CN=KUBERNETES-CA" -out alice.csr

### Create csr object
cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1beta1
kind: CertificateSigningRequest
metadata:
  name: alice-developer
spec:
  request: $(cat alice.csr | base64 | tr -d '\n')
  usages:
  - digital signature
  - key encipherment
  - server auth
EOF
kubectl certificate approve alice-developer

### Create Role
kubectl create role developer --verb=create,list,get,update,delete --resource=pods -n development

### Create RoleBinding
kubectl create rolebinding developer-alice --role=developer --user=alice -n development

### Try Impersonate Auth
kubectl auth can-i update pods -n development --as=alice