resource "aws_key_pair" "ro_key" {
  key_name   = var.INSTANCE_NAME
  public_key = file(var.PATH_TO_PUBLIC_KEY)

  tags = {
    Name             = var.INSTANCE_NAME
    L1_AREA          = var.L1_AREA
    L5_PRODUCT       = var.L5_PRODUCT
    L6_ENVIRONMENT   = var.L6_ENVIRONMENT
    L7_FUNCTIONALITY = var.L7_FUNCTIONALITY
    L8_TEAM          = var.L8_TEAM
  }
}
