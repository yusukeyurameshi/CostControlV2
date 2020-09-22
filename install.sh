#!/bin/bash

CRON="0 10 * * * timeout 6h /home/opc/CostControlV2/shell_scripts/run_daily.sh"

sudo yum install -y git
sudo pip3 install oci oci-cli requests pandas

git clone https://github.com/yusukeyurameshi/CostControlV2.git

