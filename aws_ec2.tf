resource "aws_instance" "tf-my-instance-a" {
  ami                    = "ami-03d79d440297083e3"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ec2-sg.id]
  subnet_id              = aws_subnet.public-subnet-1a.id
  key_name               = aws_key_pair.myKeyPair.key_name

  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_type = "gp2"
    volume_size = "100"
  }

  tags = {
    Name = "tf-my-instance-a"
  }
}

resource "aws_instance" "tf-my-instance-c" {
  ami                    = "ami-03d79d440297083e3"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ec2-sg.id]
  subnet_id              = aws_subnet.public-subnet-1c.id
  key_name               = aws_key_pair.myKeyPair.key_name

  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_type = "gp2"
    volume_size = "100"
  }

  tags = {
    Name = "tf-my-instance-c"
  }
}