#!/bin/bash

# Check if Terraform is installed
if ! command -v terraform &>/dev/null; then
    echo "Terraform could not be found."
    exit 1
fi

# Check Terraform version
TERRAFORM_VERSION=$(terraform version -json | jq -r '.terraform_version')

if [[ "$TERRAFORM_VERSION" != "1.5.4" ]]; then
    echo "Terraform version 1.5.4 is required."
    exit 1
fi

echo "Terraform is installed and the version is 1.5.4"
