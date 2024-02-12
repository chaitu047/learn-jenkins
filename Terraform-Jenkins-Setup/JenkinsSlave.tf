resource "aws_instance" "JenkinsSlave" {
  ami                    = data.aws_ami.centos-ami.id
  instance_type          = "t3.small"
  availability_zone      = "us-east-1b"
  vpc_security_group_ids = [data.aws_security_group.allowall.id]
  key_name               = "dev-ssh"
  root_block_device {
    delete_on_termination = true
    volume_size           = 20
    volume_type           = "gp2"
  }
  tags = {
    Name = "JenkinsSlave"
  }
}

resource "null_resource" "ec2-provision-slave" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    cluster_instance_ids = aws_instance.JenkinsSlave.id
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    type     = "ssh"
    user     = "centos"
    password = "DevOps321"
    host     = aws_instance.JenkinsSlave.public_ip
  }

  provisioner "file" {
    source      = "AgentSetup.sh"
    destination = "/tmp/AgentSetup.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "chmod +x /tmp/AgentSetup.sh",
      "sudo sh /tmp/AgentSetup.sh"
    ]
  }
}
