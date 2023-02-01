provider "aws" {
 region  = "us-west-2"
}

module "s3" {
    source = "/home/zak/learn-terraform-aws-bucket/s3"
    #bucket name should be unique
    #bucket_name = "msdtask2"       
}
