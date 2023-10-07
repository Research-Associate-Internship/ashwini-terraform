provider "aws" {
    region = "us-east-1"  
}

resource "aws_instance" "first" {
  ami           = "ami-067d1e60475437da2" # us-west-2
  instance_type = "t2.micro"
  tags = {
      Name = "TF-Instance"
  }
}
