resource "aws_instance" "web" {
  count            = 2
  ami              = "ami-046f6df52d1930356"
  instance_type    = "t2.micro"
  security_groups  = ["default", "launch-wizard-7"]
  key_name         = "RR-Production"
  user_data        = file("server-script.sh")
  tags = {
    Name                      = "TNonProductionWebServer"
    "aws:autoscaling:group"  = aws_autoscaling_group.web.name  # Reference to the existing Auto Scaling Group name
  }

  iam_instance_profile = "EC2CodeDeploy"
}

resource "aws_autoscaling_group" "web" {
  name                = "DEMOasg"
  desired_capacity    = 2
  max_size            = 3
  min_size            = 1
  vpc_zone_identifier = ["subnet-070dc6bbcf6ff035e", "subnet-0f130ccfac1f9a868", "subnet-0142b0c4b6b31d803"]  # Replace with your subnet IDs
  health_check_type   = "EC2"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "TNonProductionWebServer"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "Demo"
    propagate_at_launch = true
  }
}

