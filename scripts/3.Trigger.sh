#!/usr/local/bin/bash

# Check if bash version is 4.0 or higher
if [ "${BASH_VERSINFO:-0}" -lt 4 ]; then
    echo "Bash version 4.0 or higher is required."
    exit 1
fi

cd ../infrastructure

ID=$(terraform output -raw instance_id)
echo "Instance ID: $ID"

# Run SSM Document
aws ssm send-command \
    --document-name "Deploy-Strapi" \
    --instance-ids "$ID" \
    --region "eu-west-1" \
    --no-cli-pager
