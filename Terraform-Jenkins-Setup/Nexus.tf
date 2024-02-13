resource "aws_instance" "nexus" {
  ami                    = data.aws_ami.centos-ami.id
  instance_type          = "t3.medium"
  availability_zone      = "us-east-1b"
  vpc_security_group_ids = [data.aws_security_group.allowall.id]
  key_name               = "dev-ssh"
  iam_instance_profile   = "AWSTerraformRole"
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp2"
  }
  tags = {
    Name = "Nexus"
  }
}
