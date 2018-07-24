#!/bin/sh

# Install and run halyard
# https://www.spinnaker.io/setup/install/halyard/
curl -s -q -O https://raw.githubusercontent.com/spinnaker/halyard/master/install/debian/InstallHalyard.sh
sudo bash InstallHalyard.sh --user ubuntu

# Set persistent storage
# https://www.spinnaker.io/setup/install/storage/s3/
hal config storage s3 edit --region ap-northeast-1
hal config storage edit --type s3

# Deploy spinnaker
# https://www.spinnaker.io/setup/install/deploy/
hal config version edit --version 1.8.2
sudo hal deploy apply

# Export ports to external and rewrite base url
# https://blog.spinnaker.io/exposing-spinnaker-to-end-users-4808bc936698
echo "host: 0.0.0.0" | tee \
    ~/.hal/default/service-settings/gate.yml \
    ~/.hal/default/service-settings/deck.yml

hal config security ui edit \
    --override-base-url \
    http://`curl -s http://169.254.169.254/latest/meta-data/public-hostname`:9000

hal config security api edit \
    --override-base-url \
    http://`curl -s http://169.254.169.254/latest/meta-data/public-hostname`:8084

sudo hal deploy apply

sudo systemctl restart apache2
sudo systemctl restart gate
sudo systemctl restart orca
sudo systemctl restart igor
sudo systemctl restart front50
sudo systemctl restart echo
sudo systemctl restart clouddriver
sudo systemctl restart rosco
