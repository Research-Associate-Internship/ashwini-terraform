provider "aws" {
    region = "us-east-1"  
}
resource "aws_instance" "first" {
  ami           = "ami-03a6eaae9938c858c" # us-west-2
  instance_type = "t2.micro"
  tags = {
      Name = "TF-Instance"
  }
}
import {
  to = aws_default_vpc.default
  id = "vpc-005db026359877d5e"
}