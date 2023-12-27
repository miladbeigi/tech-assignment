# Project Setup and Deployment

This document provides instructions on how to set up the infrastructure and deploy the instance for this project.

## Prerequisites

- Bash v4.0+
- AWS CLI
- Terraform
- Docker
- SSM Session Manager Plugin

### 1. Check Requirements

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

### 2. AWS Credentials

AWS credentials are required to apply the Terraform configuration. The credentials must have the administrator access policy attached to it. Make sure you have the credentials configured in your environment. You can check this by running the following command:

```bash
aws sts get-caller-identity
```

### 3. Applying Terraform Configuration

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

This should create the infrastructure in AWS. The instance is configured to install necessary tools when it starts. The instance will also clone the repository in the home directory for further deployment steps.

### 4. Secrets

Create the .env file in `app` directory and update it with the required values. Some possible values are stored in .env.example.

Although the secrets are created by Terraform, the "real" values are not stored in the state file. There is a script that will read the values from the .env file and update the SSM parameters. To run the script, **go to the scripts directory** and run the following command:

```bash
./1.Secrets.sh
```

Make sure the AWS_REGION variable is set to the same region as the infrastructure.

### 5. Trigger Deployment

To trigger the application deployment, we need to run a script on the instance. I chose to use SSM Run Command to run the script on the instance. To trigger the deployment, **go to the scripts directory** and run the following command:

```bash
./3.Trigger.sh
```

The script will get the instance ID from the Terraform state file and run the script on the instance. The script itself is `2.Deploy.sh` and it will run the deployment script on the instance. We don't need to run `2.Deploy.sh` directly because it should be run on the instance.

The output of the script will give us the command ID. We can use this command ID to check the status of the deployment.

### 6. Check Deployment

To check if the deployment was successful, we can run the following command:

```bash
aws ssm get-command-invocation --command-id <command-id> --instance-id <instance-id> --output text
```

The command ID is the ID we got from the previous step. The instance ID is the ID of the instance we got from the Terraform state file.

### 7. Check Application

To check if the application is running, we can run check the load balancer DNS name. We can get the DNS name from the Terraform output variable. To get the output variable, we can run the following command:

```bash
terraform output -raw alb_dns_name
```

By going `/admin` we can set up the admin user and login to the admin panel.

# Troubleshooting

### How to connect to the instance

To connect to the instance, we can use SSM Session Manager. To connect to the instance, we can run the following command:

```bash
aws ssm start-session --target <instance-id>
```

### How to port forward to the instance to check the application locally

To port forward to the instance, we can use SSM Session Manager. To port forward to the instance, we can run the following command:

```bash
aws ssm start-session --target <instance-id> --document-name AWS-StartPortForwardingSession --parameters '{"portNumber":["80"],"localPortNumber":["8080"]}'
```
