provider "aws" {
  region = "us-east-1"
  profile = "tuprimeroapi"
}

# Crear Gurpos de seguridad
resource "aws_security_group" "sg_application" {
  vpc_id = "vpc-05a9f46d9f82d6195"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 5601
    to_port     = 5601
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["172.31.16.0/20"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sg_application"
  }
}

resource "aws_instance" "ec2_es00" {
  ami             = "ami-064519b8c76274859"
  instance_type   = "t2.micro"
  subnet_id       = "subnet-0100cfab5d482fc8e"
  security_groups = [aws_security_group.sg_application.id]
  key_name        = "ApolloKibana"
  tags = {
    Name = "Es00"
  }
}

resource "aws_instance" "ec2_es01" {
  ami             = "ami-064519b8c76274859"
  instance_type   = "t2.small"
  subnet_id       = "subnet-0100cfab5d482fc8e"
  security_groups = [aws_security_group.sg_application.id]
  key_name        = "ApolloKibana"
  tags = {
    Name = "Es01"
  }
}

resource "aws_instance" "ec2_es02" {
  ami             = "ami-064519b8c76274859"
  instance_type   = "t2.small"
  subnet_id       = "subnet-0100cfab5d482fc8e"
  security_groups = [aws_security_group.sg_application.id]
  key_name        = "ApolloKibana"
  tags = {
    Name = "Es02"
  }
}

resource "aws_instance" "ec2_kibana" {
  ami             = "ami-064519b8c76274859"
  instance_type   = "t2.small"
  subnet_id       = "subnet-0100cfab5d482fc8e"
  security_groups = [aws_security_group.sg_application.id]
  key_name        = "ApolloKibana"
  tags = {
    Name = "Kibana"
  }
}

resource "aws_instance" "ec2_apollo" {
  ami             = "ami-064519b8c76274859"
  instance_type   = "t2.micro"
  subnet_id       = "subnet-0100cfab5d482fc8e"
  security_groups = [aws_security_group.sg_application.id]
  key_name        = "ApolloKibana"
  tags = {
    Name = "Apollo"
  }
}

output "public_ips" {
  value = [
    aws_instance.ec2_es00.public_ip,
    aws_instance.ec2_es01.public_ip,
    aws_instance.ec2_es02.public_ip,
    aws_instance.ec2_kibana.public_ip,
    aws_instance.ec2_apollo.public_ip,
  ]
}

output "private_ips" {
  value = [
    aws_instance.ec2_es00.private_ip,
    aws_instance.ec2_es01.private_ip,
    aws_instance.ec2_es02.private_ip,
    aws_instance.ec2_kibana.private_ip,
    aws_instance.ec2_apollo.private_ip,
  ]
}