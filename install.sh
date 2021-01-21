#!/bin/bash

sudo yum install -y git python3
sudo pip3 install oci oci-cli requests pandas

git clone https://github.com/yusukeyurameshi/CostControlV2.git

cat /home/opc/CostControlV2/crontab.txt | crontab -

/home/opc/CostControlV2/shell_scripts/run_daily.sh

