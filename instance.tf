resource "aws_spot_instance_request" "instance_aws" {

  ami                                  = var.AMI
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = var.INSTANCE_TYPE
  block_duration_minutes               = var.BLOCK_DURATION_MINUTES
  wait_for_fulfillment                 = true
  spot_type                            = "one-time"

  #   the VPC subnet
  subnet_id = aws_subnet.main-public-1.id

  root_block_device {
    delete_on_termination = true
    volume_size           = var.VOLUME_SIZE
  }

  tags = {
    Name             = var.INSTANCE_NAME
    L1_AREA          = var.L1_AREA
    L5_PRODUCT       = var.L5_PRODUCT
    L6_ENVIRONMENT   = var.L6_ENVIRONMENT
    L7_FUNCTIONALITY = var.L7_FUNCTIONALITY
    L8_TEAM          = var.L8_TEAM
  }

  volume_tags = {
    Name             = var.INSTANCE_NAME
    L1_AREA          = var.L1_AREA
    L5_PRODUCT       = var.L5_PRODUCT
    L6_ENVIRONMENT   = var.L6_ENVIRONMENT
    L7_FUNCTIONALITY = var.L7_FUNCTIONALITY
    L8_TEAM          = var.L8_TEAM
  }

  provisioner "file" {
    content     = data.template_file.add-tags.rendered
    destination = "/tmp/add-tags.sh"
  }

  provisioner "file" {
    content     = data.template_file.docker_shell.rendered
    destination = "/tmp/install_docker.sh"
  }

  provisioner "file" {
    source      = "scripts/jenkins/docker-compose.yml"
    destination = "/tmp/docker-compose.yml"
  }

  provisioner "file" {
    source      = "scripts/jenkins/Dockerfile"
    destination = "/tmp/Dockerfile"
  }

  provisioner "file" {
    source      = "scripts/jenkins/install_jenkins.sh"
    destination = "/tmp/install_jenkins.sh"
  }    


  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/add-tags.sh",
      "chmod +x /tmp/install_docker.sh",
      "chmod +x /tmp/install_jenkins.sh",
      "chmod +x /tmp/docker-compose.yml",
      "chmod +x /tmp/Dockerfile",
      "sudo sed -i -e 's/\r$//' /tmp/add-tags.sh",        # Remove the spurious CR characters.
      "sudo sed -i -e 's/\r$//' /tmp/install_docker.sh",         # Remove the spurious CR characters.
      "sudo sed -i -e 's/\r$//' /tmp/install_jenkins.sh", # Remove the spurious CR characters.
      "sh /tmp/add-tags.sh ${aws_spot_instance_request.instance_aws.id} ${aws_spot_instance_request.instance_aws.spot_instance_id}",
      "sudo /tmp/install_docker.sh",
      "sh /tmp/install_jenkins.sh",
    ]
  }

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }

  #   dependencies
  key_name               = aws_key_pair.ro_key.key_name
  vpc_security_group_ids = [aws_security_group.security_group.id]

}

output "ip_public" {
  value = aws_spot_instance_request.instance_aws.public_ip
}

output "public_dns" {
  value = aws_spot_instance_request.instance_aws.public_dns
}

output "spot_id" {
  value = aws_spot_instance_request.instance_aws.id
}

output "spot_instance_id" {
  value = aws_spot_instance_request.instance_aws.spot_instance_id
}