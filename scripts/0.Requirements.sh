#!/usr/bin/env bash

# Check if bash version is 4.0 or higher
if [ "${BASH_VERSINFO:-0}" -lt 4 ]; then
    echo "Bash version 4.0 or higher is required ⚠️"
    exit 1
fi
echo "Bash version ☑️"

# Check if AWS CLI is installed
if ! command -v aws &>/dev/null; then
    echo "AWS CLI could not be found ⚠️"
    exit 1
fi
echo "AWS CLI ☑️"

# Check AWS CLI version
AWS_CLI_VERSION=$(aws --version | cut -d/ -f2 | cut -d. -f1)

if [[ "$AWS_CLI_VERSION" != "2" ]]; then
    echo "AWS CLI version 2 is required ⚠️"
    exit 1
fi
echo "AWS CLI version ☑️"

# Check if Terraform is installed
if ! command -v terraform &>/dev/null; then
    echo "Terraform could not be found ⚠️"
    exit 1
fi
echo "Terraform ☑️"

# Check if jq is installed
if ! command -v jq &>/dev/null; then
    echo "jq could not be found ⚠️"
    exit 1
fi
echo "jq ☑️"

# Check Terraform version
TERRAFORM_VERSION=$(terraform version -json | jq -r '.terraform_version')

if [[ "$TERRAFORM_VERSION" != "1.5.4" ]]; then
    echo "Terraform version 1.5.4 is required ⚠️"
    exit 1
fi
echo "Terraform version ☑️"

# Check SSM Session Manager plugin
if ! command -v session-manager-plugin &>/dev/null; then
    echo "SSM Session Manager plugin could not be found ⚠️"
    echo "Check this URL: https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html"
    exit 1
fi
echo "SSM Session Manager plugin ☑️"
