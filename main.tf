resource "aws_launch_template" "BSE_LaunchTemplate" {
  name_prefix   = "BSE-LaunchTemplate-"
  image_id      = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
    echo "Instance ID: $INSTANCE_ID" > /var/www/html/index.html
  EOF
  )

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.BSE_SecurityGroup_LB.id]
  }
}
