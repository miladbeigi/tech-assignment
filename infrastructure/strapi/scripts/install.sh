#!/bin/sh

LOG_FILE="/var/log/strapi-selfhosted-install.log"

# Function to log messages to both stdout and a log file
log() {
    local message="$1"
    echo "$message" | tee -a "$LOG_FILE"
}

# Check if AWS CLI installed if not install it
if ! [ -x "$(command -v aws)" ]; then
    log "AWS CLI is not installed. Installing AWS CLI..."
    apt-get update -y
    apt-get install -y awscli
    log "AWS CLI installed successfully"
    aws --version >>"$LOG_FILE" 2>&1
else
    log "AWS CLI is already installed"
fi

# Check if docker installed if not install it
if ! [ -x "$(command -v docker)" ]; then
    log "Docker is not installed. Installing Docker..."
    apt-get update -y
    apt-get install -y docker.io
    systemctl enable docker
    systemctl start docker
    log "Docker installed successfully"
    docker --version >>"$LOG_FILE" 2>&1
    # create docker group and add ubuntu user to it
    groupadd docker
    usermod -aG docker ubuntu
else
    log "Docker is already installed"
fi

# Check if docker-compose installed if not install it
if ! [ -x "$(command -v docker-compose)" ]; then
    log "Docker-compose is not installed. Installing Docker-compose..."
    apt-get update -y
    apt-get install -y docker-compose
    log "Docker-compose installed successfully"
    docker-compose --version >>"$LOG_FILE" 2>&1
else
    log "Docker-compose is already installed"
fi

# Check if git installed if not install it
if ! [ -x "$(command -v git)" ]; then
    log "Git is not installed. Installing Git..."
    apt-get update -y
    apt-get install -y git
    log "Git installed successfully"
    git --version >>"$LOG_FILE" 2>&1
else
    log "Git is already installed"
fi

# Clone the repository
log "Cloning the repository..."
cd /home/ubuntu
git clone https://github.com/miladbeigi/tech-assignment/
