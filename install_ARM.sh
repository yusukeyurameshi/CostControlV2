#!/bin/bash

sudo yum install -y git python3 platform-python-devel.aarch64

sudo pip3 install cython
sudo pip3 install numpy
sudo pip3 install oci oci-cli requests pandas

git clone https://github.com/yusukeyurameshi/CostControlV2.git

cat /home/opc/CostControlV2/crontab.txt | crontab -

/home/opc/CostControlV2/shell_scripts/run_daily.sh

