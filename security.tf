resource "aws_security_group" "BSE_SecurityGroup_LB" {
  name        = "BSE_SecurityGroup_LB"
  description = "Allow HTTP traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
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

# Récupération du VPC par défaut
data "aws_vpc" "default" {
  default = true
}