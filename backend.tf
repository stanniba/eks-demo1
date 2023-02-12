terraform {
    backend "s3"{
        bucket = "stannbucket1"
        region = "us-east-1"
        key = "elasticache/terraform.tfstate"
    }
}