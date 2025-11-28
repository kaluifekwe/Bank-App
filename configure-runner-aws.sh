#!/bin/bash
# Configure AWS credentials in GitHub runner container

echo "Configuring AWS credentials for GitHub runner..."

# Your AWS credentials (replace with your actual credentials)
AWS_ACCESS_KEY_ID="YOUR_ACCESS_KEY_HERE"
AWS_SECRET_ACCESS_KEY="YOUR_SECRET_ACCESS_KEY_HERE"
AWS_REGION="us-east-1"

# Configure AWS CLI inside the runner container
docker exec github-runner bash -c "mkdir -p /root/.aws"

docker exec github-runner bash -c "cat > /root/.aws/credentials <<EOF
[default]
aws_access_key_id = ${AWS_ACCESS_KEY_ID}
aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}
EOF"

docker exec github-runner bash -c "cat > /root/.aws/config <<EOF
[default]
region = ${AWS_REGION}
output = json
EOF"

# Set proper permissions
docker exec github-runner chmod 600 /root/.aws/credentials
docker exec github-runner chmod 600 /root/.aws/config

# Verify configuration
echo "Testing AWS configuration..."
docker exec github-runner aws sts get-caller-identity

echo "✓ AWS credentials configured successfully!"
