#!/usr/local/bin/bash

# Check if AWS Session Manager plugin is installed
if ! command -v session-manager-plugin &>/dev/null; then
    echo "AWS Session Manager plugin could not be found."
fi
