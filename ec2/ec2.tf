resource "aws_instance" "web" {
  count            = 2
  ami              = "ami-046f6df52d1930356"
  instance_type    = "t2.micro"
  security_groups  = ["default", "launch-wizard-7"]
  key_name         = "RR-Production"
  user_data        = file("server-script.sh")
  tags = {
    Name = "TNonProductionWebServer"
    "aws:autoscaling:group"  = "DEMOasg"  # Add Auto Scaling Group name as a tag
  }

  iam_instance_profile = "EC2CodeDeploy"
}


