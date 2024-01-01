terraform {
  backend "s3" {
    bucket         = "whiteboard-state"
    key            = "eks-infra/terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
  }
}
