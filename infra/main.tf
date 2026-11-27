resource "aws_security_group" "db" {
  name = "db-sg"
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# Таблица без point-in-time recovery
resource "aws_dynamodb_table" "orders" {
  name         = "orders"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"
  attribute {
    name = "id"
    type = "S"
  }
}
# Небольшой сервер
resource "aws_instance" "app" {
  ami           = "ami-0123456789abcdef0"
  instance_type = "t3.micro"
}
