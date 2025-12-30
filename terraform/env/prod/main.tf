module "vpc" {
  source = "../../modules/vpc"

  name            = var.project_name
  cidr_block      = "10.0.0.0/16"

  azs = [
    "ap-southeast-1a",
    "ap-southeast-1b"
  ]

  public_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnets = [
    "10.0.101.0/24",
    "10.0.102.0/24"
  ]
}