module "vpc" {
  source = "../../modules/vpc"

  name            = var.project_name
  cidr_block      = "10.10.0.0/16"

  azs = [
    "ap-southeast-2a",
    "ap-southeast-2b"
  ]

  public_subnets = [
    "10.10.1.0/24",
    "10.10.2.0/24"
  ]

}