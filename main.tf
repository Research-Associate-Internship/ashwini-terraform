provider "aws" {
    region = "us-east-1"  
}
resource "aws_instance" "Hashicorp-instance" {
  ami           = "ami-0dbc3d7bc646e8516"
  instance_type = "t2.micro"
  subnet_id = "subnet-0860b49c7e7abaa7a"
  key_name = "docker-jenkins"
  tags = {
    Name       = "HashiCorp-Instance"
  }
}
