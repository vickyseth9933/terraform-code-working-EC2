#proving provider details , in provider details we have provide region ( mandatory )
#access key and secret key are configured using awscli


provider "aws" {
  region = "us-east-1"

}

##local terraform.tfstate file will go to s3 bucket with version available, we need to create bucket first then mention the name of the bucket in bucket key
##in key we have to enter the file name which we want to goto s3 bucket

terraform {
  backend "s3" {
    bucket = "sandeep9040"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}


