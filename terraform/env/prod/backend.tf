terraform {
  backend "s3" {
    bucket         = "cruddur-terraform-state"
    key            = "profile-project.tfstate"
    region         = "ap-southeast-2"
    encrypt        = true
  }
}