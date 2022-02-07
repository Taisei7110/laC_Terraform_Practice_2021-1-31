resource "aws_eip" "my-eip-a" {
  vpc = true
}

resource "aws_eip" "my-eip-c" {
  vpc = true
}

resource "aws_eip_association" "eip_association-a" {
  instance_id   = aws_instance.tf-my-instance-a.id
  allocation_id = aws_eip.my-eip-a.id
}

resource "aws_eip_association" "eip_association-c" {
  instance_id   = aws_instance.tf-my-instance-c.id
  allocation_id = aws_eip.my-eip-c.id
}