# data "http" "myip" {
#   url = "http://ipv4.icanhazip.com"
# }

# data "aws_vpc" "stage" {
#     filter {
#     name = "tag:Name"
#     values = ["stage-vpc"]
#   }
# }


resource "aws_security_group" "apache" {
  name        = "allow_apache"
  description = "Allow apache inbound traffic"
  vpc_id      = aws_vpc.vpc.id



  ingress {
    description     = "ssh from admin"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]


  }


  ingress {
    description     = "for alb end users"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name      = "stage-apache-sg",
    terraform = "true"
  }
}

