
data "aws_security_group" "rds-ec2-7" {
  name = "rds-ec2-7
}

data "aws_security_group" "rds-ec2-8" {
  name = "rds-ec2-8"
}

resource "aws_db_instance" "myRDS" {
  engine                = "mysql"
  instance_class        = "db.t3.micro"
  allocated_storage     = 20
  storage_type          = "gp2"
  identifier            = "database-2"
  db_name                  = "purchases"
  username              = "admin"
  password              = "vl10055480"
  port                  = 3306
  skip_final_snapshot   = true
  publicly_accessible  = true
  snapshot_identifier   = "database-2-mysql"

  vpc_security_group_ids = [
    data.aws_security_group.rds-ec2-7.id,
    data.aws_security_group.rds-ec2-8.id
  ]
  
  availability_zone = "us-east-2c"
}
