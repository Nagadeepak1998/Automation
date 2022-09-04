resource "aws_security_group" "bastion" {
<<<<<<< HEAD
  name        = "bastion-demo13deepak"
=======
  name        = "bastion-demo12deepak"
>>>>>>> 1e26859db1cfdda19b06034060b949b7b4009e28
  description = "Allow admin with ssh"
  vpc_id      = "vpc-07c6deb7b2da13b5a"

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
<<<<<<< HEAD
    Name      = "bastion-demo13deepak"
=======
    Name      = "bastion-demo12deepak"
>>>>>>> 1e26859db1cfdda19b06034060b949b7b4009e28
    terraform = "true"
  }

}

resource "aws_security_group" "apache" {
  name        = "apache-demo"
  description = "Allow enduser"
  vpc_id      = "vpc-07c6deb7b2da13b5a"

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
