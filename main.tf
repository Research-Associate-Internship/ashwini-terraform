provider "aws" {
    region = "us-east-1"  
}
resource "aws_instance" "first" {
  ami           = "ami-03a6eaae9938c858c" # us-west-2
  instance_type = "t2.micro"
  subnet_id = "subnet-0860b49c7e7abaa7a"
  tags = {
      Name = "TF-Instance"
  }
}
resource "aws_ec2_instance_state" "first" {
  instance_id = aws_instance.first.id
  state       = "stopped"
}