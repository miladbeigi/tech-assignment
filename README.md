# Project Setup and Deployment

This document provides instructions on how to set up the infrastructure and deploy the instance for this project.

## Prerequisites

- Bash v4.0+
- AWS CLI
- Terraform
- Docker
- SSM Session Manager Plugin

### Check Requirements

To make sure you have all the required tools installed, run the following command:

```bash
./scripts/0.Requirements.sh
```

This script will check if you have:

- Bash v4.0+
- AWS CLI v2.0+
- JQ
- Terraform v1.5.4 (The version installed on my laptop)
- SSM Session Manager Plugin

### AWS Credentials

AWS credentials are required to apply the Terraform configuration. The credentials must have the administrator access policy attached to it. Make sure you have the credentials configured in your environment. You can check this by running the following command:

```bash
aws sts get-caller-identity
```

# Infrastructure

## Applying Terraform Configuration

1. Go to infrastructure directory
2. Make sure the variables in `terraform.tfvars` are according to your needs.
   - The region determines where the infrastructure will be deployed. The default is `eu-west-1`.
3. Run the following command to initialize the Terraform configuration:

```bash
terraform init
```

4. Run the following command to check the Terraform plan:

```bash
terraform plan
```

5. Run the following command to apply the Terraform configuration:

```bash
terraform apply -auto-approve
```

# Secrets

Create the .env file in app directory and update it with the required values. Some possible values are stored in .env.example.

Although the secrets are created by Terraform, the "real" values are not stored in the state file. There is a script that will read the values from the .env file and update the SSM parameters. To run the script, go to the scripts directory and run the following command:

```bash
./1.Secrets.sh
```

Make sure the AWS_REGION variable is set to the same region as the infrastructure.

# Trigger Deployment
