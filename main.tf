provider "aws" {
  region = "us-west-2"
}



module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "single-instance"

  ami                    = "ami-ebd02392"
  instance_type          = "t3a.nano"
  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = ["sg-12345678"]
  subnet_id              = "11.22.33.44"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}