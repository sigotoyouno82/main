# セキュリティグループの作成（SSHアクセスを許可）
resource "aws_security_group" "allow_ssh" {
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # SSHアクセスを許可（セキュリティを強化するにはIP制限を推奨）
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # 全てのアウトバウンドトラフィックを許可
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ssh"
  }
}

# セキュリティグループの作成（HTTPとHTTPSアクセスを許可）
resource "aws_security_group" "allow_http_https" {
  vpc_id = aws_vpc.my_vpc.id

  # HTTP (80) アクセスを許可
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # 全世界からのHTTPアクセスを許可
  }

  # HTTPS (443) アクセスを許可
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # 全世界からのHTTPSアクセスを許可
  }

  # 全てのアウトバウンドトラフィックを許可
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-http-https"
  }
}