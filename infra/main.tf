resource "aws_iam_policy" "deploy" {
  name = "deploy-everything"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "*"
      Resource = "*"
}]
})
}
# База данных: публичная, без шифрования, без бэкапов
resource "aws_db_instance" "main" {
  identifier              = "main-db"
  engine                  = "postgres"
  instance_class          = "db.t3.medium"
  allocated_storage       = 50
  username                = "app"
  password                = "SuperSecret123!"
  publicly_accessible     = true
  storage_encrypted       = false
  backup_retention_period = 0
  skip_final_snapshot     = true
}
# NAT Gateway — дорогой ресурс
resource "aws_eip" "nat" {
  domain = "vpc"
}
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id (http://eip.nat.id/)
  subnet_id     = "subnet-0123456789abcdef0"
}
# Большой сервер
resource "aws_instance" "worker" {
  ami           = "ami-0123456789abcdef0"
  instance_type = "m5.xlarge"
}


# check 1
