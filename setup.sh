#!/bin/sh

set -eux

spinnaker_host=`terraform output | grep public_dns | awk '{print $3}'`
access_key_id=`terraform output | grep access_key_id | awk '{print $3}'`
secret_access_key=`terraform output | grep secret_access_key | awk '{print $3}' | sed -e 's/\//\\\\\//g'`
account_id=`terraform output | grep account_id | awk '{print $3}'`

scp -o StrictHostKeyChecking=no install_spinnaker.sh $spinnaker_host:~/
ssh $spinnaker_host chmod +x ./install_spinnaker.sh
ssh $spinnaker_host ./install_spinnaker.sh

sed -i -e "s/\$access_key_id/$access_key_id/g" configure_spinnaker.sh
sed -i -e "s/\$secret_access_key/$secret_access_key/g" configure_spinnaker.sh
sed -i -e "s/\$account_id/$account_id/g" configure_spinnaker.sh

scp configure_spinnaker.sh $spinnaker_host:~/
git checkout configure_spinnaker.sh
ssh $spinnaker_host chmod +x ./configure_spinnaker.sh
ssh $spinnaker_host ./configure_spinnaker.sh

# For debugging deck
#scp setup_node_and_deck.sh $spinnaker_host:~/
#ssh $spinnaker_host chmod +x ./setup_node_and_deck.sh
#ssh $spinnaker_host ./setup_node_and_deck.sh
