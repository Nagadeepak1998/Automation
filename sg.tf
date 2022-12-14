resource "aws_security_group" "bastion" {
  name        = "bastion-demo13deepak"
  description = "Allow admin with ssh"
  vpc_id      = "vpc-07e33314e23d5d739"

  ingress {
    description = "connecting admin with ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["103.152.179.102/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name      = "bastion-demo13deepak"
    terraform = "true"
  }

}

resource "aws_security_group" "apache" {
  name        = "apache-demo"
  description = "Allow enduser"
  vpc_id      = "vpc-07e33314e23d5d739"

  ingress {
    description = "connecting enduser"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    # cidr_blocks = [aws_security_group.bastion.id]
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "connecting from bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # cidr_blocks = ["103.152.179.102/32"]
    security_groups = [aws_security_group.bastion.id]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name      = "apache-demo"
    terraform = "true"
  }

}
