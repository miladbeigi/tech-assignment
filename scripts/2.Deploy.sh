#!/usr/bin/env bash

cd /home/ubuntu/tech-assignment/app

declare -A params

params[cms_database_username]=DATABASE_USERNAME
params[cms_database_password]=DATABASE_PASSWORD
params[cms_jwt_secret]=JWT_SECRET
params[cms_admin_jwt_secret]=ADMIN_JWT_SECRET
params[cms_app_keys]=APP_KEYS
params[cms_api_token_salt]=API_TOKEN_SALT
params[cms_transfer_token_salt]=TRANSFER_TOKEN_SALT

for key in "${!params[@]}"; do
    echo $key
    value=$(aws ssm get-parameter --name $key --with-decryption --query Parameter.Value --output text --region eu-west-1)
    if [ -z "$value" ]; then
        echo "Parameter $key is empty"
        exit 1
    fi
    echo "${params[$key]}=$value" >>.env
done

docker pull miladbeigi/strapiv4:0.1.1

# Build and deploy
docker-compose up -d

# Cleanup
rm .env
