provider "aws" {
  region = "ap-south-1"
  access_key = ""
  secret_key = ""
}

resource "aws_key_pair" "example" {
  key_name   = "key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "web" {
  ami             = "ami-0f918f7e67a3323f0"
  instance_type   = "t2 micro"
  key_name        = aws_key_pair.example.key_name
  security_groups = [aws_security_group.tf_sg.name]
}
provisioner "file" {
    source      = "script.sh"
    destination = "/ home/ubuntu/script.sh"
    }
}
connection {
   type         = "ssh"
   user         = "ubuntu"
   private_key  = file("~/.ssh/id_rsa")
   host         = self.public_ip
   }
}
resource "aws_security_group" "tf_sg" {
  name        = "tf_sg"
  description = "Allow HTTPS to web server"
  vpc_id      = "vpc-05bdcc8880aab85ab"
}
 ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    
  }
 ingress {
    description = "TLS from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
