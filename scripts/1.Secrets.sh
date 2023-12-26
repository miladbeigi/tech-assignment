#!/usr/bin/env bash

# Check if bash version is 4.0 or higher
if [ "${BASH_VERSINFO:-0}" -lt 4 ]; then
    echo "Bash version 4.0 or higher is required."
    exit 1
fi

set -a

source ../app/.env

# Check if variables are set
if [ -z "$DATABASE_USERNAME" ]; then
    echo "DATABASE_USERNAME is not set."
    exit 1
fi

set +a

declare -A params

params[cms_database_username]=$DATABASE_USERNAME
params[cms_database_password]=$DATABASE_PASSWORD
params[cms_jwt_secret]=$JWT_SECRET
params[cms_admin_jwt_secret]=$ADMIN_JWT_SECRET
params[cms_app_keys]=$APP_KEYS
params[cms_api_token_salt]=$API_TOKEN_SALT
params[cms_transfer_token_salt]=$TRANSFER_TOKEN_SALT

# Update the parameters in SSM Parameter Store
for key in "${!params[@]}"; do
    echo "Updating ${key}..."
    aws ssm put-parameter \
        --name "${key}" \
        --value "${params[$key]}" \
        --type SecureString \
        --region $AWS_REGION \
        --overwrite \
        --no-cli-pager
done
