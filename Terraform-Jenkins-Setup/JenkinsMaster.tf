resource "aws_instance" "JenkinsMaster" {
  ami                    = data.aws_ami.centos-ami.id
  instance_type          = "t3.small"
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
    Name = "JenkinsMaster"
  }
}

resource "null_resource" "ec2-provision-master" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    cluster_instance_ids = aws_instance.JenkinsMaster.id
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    type     = "ssh"
    user     = "centos"
    password = "DevOps321"
    host     = aws_instance.JenkinsMaster.public_ip
  }

  provisioner "file" {
    source      = "JenkinsSetup.sh"
    destination = "/tmp/JenkinsSetup.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "chmod +x /tmp/JenkinsSetup.sh",
      "sudo sh /tmp/JenkinsSetup.sh"
    ]
  }
}
