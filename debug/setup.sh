#!/bin/sh

set -eux

spinnaker_host=`cd .. && terraform output | grep public_dns | awk '{print $3}'`
access_key_id=`cd .. && terraform output | grep access_key_id | awk '{print $3}'`
secret_access_key=`cd .. && terraform output | grep secret_access_key | awk '{print $3}' | sed -e 's/\//\\\\\//g'`
account_id=`cd .. && terraform output | grep account_id | awk '{print $3}'`

scp -o StrictHostKeyChecking=no prepare.sh $spinnaker_host:~/
ssh $spinnaker_host chmod +x ./prepare.sh
ssh $spinnaker_host ./prepare.sh

sed -i -e "s/\$access_key_id/$access_key_id/g" configure.sh
sed -i -e "s/\$secret_access_key/$secret_access_key/g" configure.sh
sed -i -e "s/\$account_id/$account_id/g" configure.sh

scp configure.sh $spinnaker_host:~/
ssh $spinnaker_host chmod +x ./configure.sh
