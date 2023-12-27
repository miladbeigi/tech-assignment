#!/usr/bin/env bash

### THIS RUNS ON THE EC2 INSTANCE ###

# Check if assumed role on the EC2 instance is valid
ROLE_NAME=$(aws sts get-caller-identity --query Arn --output text | cut -d/ -f2)

if [[ "$ROLE_NAME" != "strapi-role" ]]; then
    echo "Assumed role is not valid ⚠️"
    exit 1
fi

Version=$1
Region=$2

LOG_FILE="/var/log/strapi-selfhosted-install.log"

# Function to log messages to both stdout and a log file
log() {
    local message="$1"
    echo "$message" | tee -a "$LOG_FILE"
}

# Check if Version and Region are passed as arguments
if [ -z "$Version" ] || [ -z "$Region" ]; then
    log "Version and Region are required"
    exit 1
fi
log "Version: $Version"
log "Region: $Region"

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
    log $key
    value=$(aws ssm get-parameter --name $key --with-decryption --query Parameter.Value --output text --region $Region)
    if [ -z "$value" ]; then
        log "Parameter $key is empty"
        exit 1
    fi
    echo "${params[$key]}=$value" >>.env
done

log "Pulling the latest version of the app from Docker Hub..."
docker pull miladbeigi/strapiv4:$Version

log "Starting the app..."
TAG=$Version docker-compose --file docker-compose.prod.yml up -d

log "Removing the .env file..."
rm .env

log "App started successfully"
