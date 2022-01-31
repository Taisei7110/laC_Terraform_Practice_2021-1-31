resource "aws_eip" "my-eip" {
  vpc = true
}

resource "aws_eip_association" "eip_association-a" {
  instance_id   = aws_instance.tf-my-instance-a.id
  allocation_id = aws_eip.my-eip.id
}

resource "aws_eip_association" "eip_association-c" {
  instance_id = aws_instance.tf-my-instance-c.id
  allocation_id = aws_eip.my-eip.id
}