provider "aws" {
  access_key = ""
  secret_key = ""
  region = "ap-south-1"
}
resource "aws_instance" "example" {
  ami           = "ami-009110a2bf8d7dd0a"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Terraform AWS demo test, !!!!!" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

tags = {
Name = "terraform-aws-demo" 
}
}
resource "aws_security_group" "instance" {
  name = "terraform-aws-demo-instance"
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
