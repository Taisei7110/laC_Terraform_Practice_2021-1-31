output "eip" {
  value = "aws_eip.my-eip.public_ip"
}

output "rds-endpoint" {
  value = "aws_db_instance.my-db.endpoint"
}