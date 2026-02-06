resource "aws_vpc" "this" {}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.ap-southeast-2.dynamodb"
  vpc_endpoint_type = "Gateway"
}