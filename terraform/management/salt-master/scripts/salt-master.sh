#!/bin/bash
set -e

apt-get update -yqq && apt-get install -yqq curl wget

cat << EOF > /etc/apt/sources.list.d/saltstack.list
deb http://repo.saltstack.com/apt/ubuntu/18.04/amd64/2019.2 bionic main
EOF

curl -fsS Lhttps://repo.saltstack.com/apt/ubuntu/18.04/amd64/2019.2/SALTSTACK-GPG-KEY.pub | sudo apt-key add -

apt-get clean -yqq
apt-get update -yqq
apt-get install -yqq \
    salt-master \
    salt-minion \
    salt-ssh \
    salt-syndic \
    salt-cloud \
    salt-api \
    python-boto \
    python-boto3 \
    python-pyinotify \
    python-psutil \
    reclass

systemctl enable salt-master
systemctl enable salt-minion

systemctl daemon-reload

systemctl restart salt-master
systemctl restart salt-minion
