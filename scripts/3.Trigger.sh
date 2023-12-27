#!/usr/bin/env bash

# Check if Default region is set
if [ -z "$AWS_REGION" ]; then
    echo "Default region is not set ⚠️"
    exit 1
fi

cd ../infrastructure

ID=$(terraform output -raw instance_id)
echo "Instance ID: $ID"
echo "AWS Region: $AWS_REGION"

# Run SSM Document
command_id=$(aws ssm send-command \
    --document-name "Deploy-Strapi" \
    --instance-ids "$ID" \
    --region $AWS_REGION \
    --query "Command.CommandId" \
    --output text \
    --no-cli-pager)

echo "Command ID: $command_id"
