provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}


resource "aws_security_group" "test_sg" {
  name        = "test_sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-0cd45b88be8c2a417"

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    #prefix_list_ids = ["pl-12c4e678"]
  }
}

resource "aws_key_pair" "test_kp" {
  key_name   = "test_kp"
  public_key = "ssh-rsa Khey5MLSePEQFD+6WgyYGoUHRErh5wREgZ33N4tDFf6WFVa9avU2vhXcmmXipF3kEsdjyrlPD0eNdR4sRdIepiyGzw25EHMEcvI9/6+wt7KRDVuMFKNwcAaB7X4mJTxRaqR6G4XHj2yRvreEgytzw9wqTBn6c8o0k2Xpb0GVQeyCddVkR3mxftKv7AIgiORK8/H/tEEjmiAPhEZFRk9J08DhgkCLXSUHsebWl75F6AYytUpUKLLhffZgRSiaJxqgbWYuypN5U2hwWnVetIx+ThYzwL0xa4NMt8BvIeYxcqRSMMbnrgZe/ddbN5992qyXlUBGeDLs5ZCZ4HlxjkMtr ayazpatel@Ayazs-Mac-mini-1.attlocal.net"
}

resource "aws_instance" "ec2_instance" {
  ami                    = "ami-00068cd7555f543d5"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.test_sg.id}"]
  key_name               = aws_key_pair.test_kp.id

  tags = {
    Name = "my-first-webserver-dev"
  }
}


