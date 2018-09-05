#!/bin/sh

set -eux

./hal config storage s3 edit --region ap-northeast-1
./hal config storage edit --type s3

#./hal config deploy edit --type=localgit --git-origin-user=mizzy
./hal config version edit --version 1.9.2
./hal deploy apply --prep-only

echo "host: 0.0.0.0" | tee \
    ~/.hal/default/service-settings/gate.yml \
    ~/.hal/default/service-settings/deck.yml

./hal config security ui edit \
    --override-base-url \
    http://`curl -s http://169.254.169.254/latest/meta-data/public-hostname`:9000

./hal config security api edit \
    --override-base-url \
    http://`curl -s http://169.254.169.254/latest/meta-data/public-hostname`:8084

echo $secret_access_key \
    | ./hal config provider aws edit --access-key-id $access_key_id \
    --secret-access-key

./hal config provider aws account add my-aws-account \
    --account-id $account_id --assume-role role/spinnakerManaged

./hal config provider aws account edit my-aws-account \
    --regions ap-northeast-1

./hal config provider aws enable
