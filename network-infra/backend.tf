terraform {
  backend "s3" {
    bucket         = "whiteboard-state"
    key            = "network-infra/terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
  }
}
