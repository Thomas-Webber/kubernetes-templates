#!/usr/bin/env bash

## send files to master node

rsync -avz \
  -e "ssh -i /home/thomas/work/kubernetes/kubernetes-the-hard-way/vagrant/.vagrant/machines/master-1/virtualbox/private_key"  \
  --progress * \
  -t vagrant@192.168.5.11:~