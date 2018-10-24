#!/bin/sh


echo $secret_access_key \
    | hal config provider aws edit --access-key-id $access_key_id \
    --secret-access-key

hal config provider aws account add my-aws-account \
    --account-id $account_id --assume-role role/spinnakerManaged

hal config provider aws account edit my-aws-account \
    --regions ap-northeast-1

hal config provider aws enable

hal config provider ecs account add my-ecs-account \
    --aws-account my-aws-account
hal config provider ecs enable
 
sudo hal deploy apply

sudo systemctl restart apache2
sudo systemctl restart gate
sudo systemctl restart orca
sudo systemctl restart igor
sudo systemctl restart front50
sudo systemctl restart echo
sudo systemctl restart clouddriver
sudo systemctl restart rosco

