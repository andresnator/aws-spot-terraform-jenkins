# ************ GLOBAL TVARS ************ #
variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}


# ************ AMIS ************ #
variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AVAILABILITY_ZONE" {
  default = "us-east-1a"
}

variable "AMI" {
  default = "ami-02eac2c0129f6376b"
}


# https://aws.amazon.com/es/ec2/spot/instance-advisor/
variable "INSTANCE_TYPE" {
  default = "t2.medium"
}


variable "BLOCK_DURATION_MINUTES" {
  description = "time in minutes"
}

variable "VOLUME_SIZE" {
  default = 8
}



# ************ SSH ACCESS ************ #
variable "PATH_TO_PRIVATE_KEY" {
  default = "aws_key"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "aws_key.pub"
}


# ************ TAGS VARS ************ #
variable "L1_AREA" {
  default = "RD"
}

variable "L5_PRODUCT" {
  default = "RISK_ORCHESTRATOR"
}

variable "L6_ENVIRONMENT" {
  default = "DEVELOPMENT"
}

variable "L7_FUNCTIONALITY" {
  default = "VAULT_BANK"
}

variable "L8_TEAM" {
  default = "RISK_ORCHESTRATOR"
}



# ************ CONFIG VARS ************ #
variable "INSTANCE_USERNAME" {
  default = "centos"
}

variable "INSTANCE_NAME" {
}