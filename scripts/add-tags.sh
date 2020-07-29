#!/bin/bash

# Install additional requirements
cd /tmp/
sudo yum -y install unzip

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip -q awscliv2.zip
sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
aws --version

# # Get spot instance request tags to tags.json file
AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY} AWS_SECRET_ACCESS_KEY=${AWS_SECRET_KEY} aws --region ${AWS_REGION} ec2 describe-spot-instance-requests --spot-instance-request-ids ${SPOT_ID} --query 'SpotInstanceRequests[0].Tags' > tags.json

# # Set instance tags from tags.json file
AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY} AWS_SECRET_ACCESS_KEY=${AWS_SECRET_KEY} aws --region ${AWS_REGION} ec2 create-tags --resources ${SPOT_INSTANCE_ID} --tags file://tags.json 