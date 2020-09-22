#!/bin/bash
#############################################################################################################################
# Copyright (c) 2016, 2020, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.
#
# Author - Adi Zohar, Feb 28th 2020
#
# Run Single daily usage load for crontab use
#
# Amend variables below and database connectivity
#
# Crontab set:
# 0 0 * * * timeout 6h /home/opc/oci-python-sdk/examples/usage_reports_to_adw/shell_scripts/run_single_daily_usage2adw.sh > /home/opc/oci-python-sdk/examples/usage_reports_to_adw/shell_scripts/run_single_daily_usage2adw_crontab_run.txt 2>&1
#############################################################################################################################
# App dir
export APPDIR=$HOME/CostControlV2
export MIN_DATE=2020-01-01

# Fixed variables
export DATE=`date '+%Y%m%d_%H%M'`
export REPORT_DIR=${APPDIR}/report
mkdir -p ${REPORT_DIR}
export OUTPUT_FILE=${REPORT_DIR}/${DATE}.txt

cd $APPDIR
git pull

# execute using instance principles
echo "Running ... to $OUTPUT_FILE "

python3 $APPDIR/CostControl.py -ip > $OUTPUT_FILE

grep -i "Error" $OUTPUT_FILE
echo "Finished at `date`  "


