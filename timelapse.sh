#!/bin/bash

# this script depends on fswebcam and aws-cli,
# if doesn't exist these commands, please run the following commands
# 
# $ sudo apt-get install fswebcam
# $ sudo apt-get install python3-pip
# $ sudo pip3 install awscli --upgrade

set -e
set -u

cd /tmp

input=screenshot.jpg
output=$(date "+%Y%m%d%H%M").jpg
fswebcam -r 1280x960 --no-info --no-overlay --no-timestamp --no-banner --jpeg 95q $input
aws s3 cp $input s3://raspi-garden/$output
