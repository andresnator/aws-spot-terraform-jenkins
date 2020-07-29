resource "aws_security_group" "security_group" {
  name        = var.INSTANCE_NAME
  description = "security group that allows ro and all egress traffic"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }



  //jenkins
  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  //jenkins
  ingress {
    from_port   = 8999
    to_port     = 8999
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  //jenkins
  ingress {
    from_port   = 50000
    to_port     = 50000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name             = var.INSTANCE_NAME
    L1_AREA          = var.L1_AREA
    L5_PRODUCT       = var.L5_PRODUCT
    L6_ENVIRONMENT   = var.L6_ENVIRONMENT
    L7_FUNCTIONALITY = var.L7_FUNCTIONALITY
    L8_TEAM          = var.L8_TEAM
  }
}