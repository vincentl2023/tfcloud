resource "aws_instance" "web" {
  count = 2
  ami              = "ami-046f6df52d1930356"
  instance_type    = "t2.micro"
  security_groups  = ["default"]
  user_data        = file("server-script.sh")
  tags = {
    Name = "TNonProductionWebServer"
  }

  iam_instance_profile = "EC2CodeDeploy"

}
