#!/usr/bin/env bash

cd ../infrastructure

ID=$(terraform output -raw instance_id)
echo "Instance ID: $ID"
echo "AWS Region: $AWS_REGION"

# Run SSM Document
aws ssm send-command \
    --document-name "Deploy-Strapi" \
    --instance-ids "$ID" \
    --region $AWS_REGION \
    --no-cli-pager
