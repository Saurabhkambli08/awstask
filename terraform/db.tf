resource "aws_db_subnet_group" "default1" {
  name       = "myapp-db-subnet-group-1"
  subnet_ids = var.subnets

  tags = {
    Name = "MyApp DB subnet group"
  }
}

resource "aws_db_instance" "myapp_db" {
  identifier              = "myapp-db"
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  db_name                 = "myappdb"
  username                = "admin"
  password                = aws_secretsmanager_secret_version.db_password_version.secret_string
  db_subnet_group_name    = aws_db_subnet_group.default1.name
  skip_final_snapshot     = true
  publicly_accessible     = false
  vpc_security_group_ids  = [aws_security_group.db.id]
}

resource "aws_security_group" "db" {
  name   = "myapp-db-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_service.id]
    description     = "Allow ECS tasks to connect"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MyApp DB SG"
  }
}