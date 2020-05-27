#!/bin/bash

if [ -e ~/.ssh/id_rsa.pub ]
then
  echo -e "Skipping ssh key gen (file exists)"
  echo
  echo
  echo
  sleep 5
else
  echo -e "Generation ssh key..."
  ssh-keygen -t rsa
fi

echo -e "Copying the ssh key to the Alpine VMs"
ssh-copy-id root@192.168.1.20
ssh-copy-id root@192.168.1.21
ssh-copy-id root@192.168.1.22
ssh-copy-id root@192.168.1.23

echo -e "Configuring the Ansible Playbook"
ansible-playbook webserver.yaml -i hosts.ini

echo "Now curling each VM"
curl 192.168.1.20
sleep 5
curl 192.168.1.21
sleep 5
curl 192.168.1.22
sleep 5
curl 192.168.1.23
sleep 5
