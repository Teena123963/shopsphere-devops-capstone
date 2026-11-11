
resource "aws_db_subnet_group" "shopsphere_db_subnets" {
  name = "shopsphere-db-subnet-group"
  subnet_ids = [
    aws_subnet.db_a.id,
    aws_subnet.db_b.id
  ]

  description = "Private DB subnets for ShopSphere RDS"

  tags = {
    Name    = "ShopSphere-DB-Subnet-Group"
    Project = "ShopSphere"
  }
}

resource "aws_db_instance" "shopsphere_postgres" {
  identifier = "shopsphere-postgres"

  engine         = "postgres"
  engine_version = "16"
  instance_class = "db.t3.micro"

  allocated_storage     = 20
  max_allocated_storage = 20
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name  = "shopsphere"
  username = "shopsphere"

  manage_master_user_password = true

  db_subnet_group_name   = aws_db_subnet_group.shopsphere_db_subnets.name
  vpc_security_group_ids = ["sg-05ad59980055a9106"]
  publicly_accessible    = false

  multi_az                   = false
  backup_retention_period    = 1
  auto_minor_version_upgrade = true

  skip_final_snapshot = true
  deletion_protection = false

  tags = {
    Name    = "ShopSphere-PostgreSQL"
    Project = "ShopSphere"
  }
}
