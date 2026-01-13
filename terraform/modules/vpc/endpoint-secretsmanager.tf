resource "aws_vpc_endpoint" "secretsmanager" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.${var.region}.secretsmanager"
  vpc_endpoint_type = "Interface"

  subnet_ids = aws_subnet.public[*].id
  

  security_group_ids = var.security_group_ids

  private_dns_enabled = true
}