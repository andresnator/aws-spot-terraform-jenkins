data "template_file" "docker_shell" {
  template = file("scripts/install_ssh.sh")
  vars = {
    USER = var.INSTANCE_USERNAME
  }
}



data "template_file" "add-tags" {
  template = file("scripts/add-tags.sh")
  vars = {
    AWS_ACCESS_KEY   = var.AWS_ACCESS_KEY
    AWS_SECRET_KEY   = var.AWS_SECRET_KEY
    AWS_REGION       = var.AWS_REGION
    SPOT_ID          = "$${1}"
    SPOT_INSTANCE_ID = "$${2}"
  }
}



data "template_cloudinit_config" "init-main" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.docker_shell.rendered
  }


}