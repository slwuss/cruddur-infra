resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.${var.region}.dynamodb"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.public.id
  ]

  policy = jsonencode({
    Version = "2008-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "*"
        Resource  = "*"
      }
    ]
  })

  tags = {
    Name = "ddb-${var.name}"
  }
}