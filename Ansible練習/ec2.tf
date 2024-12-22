# Public Subnet 1にEC2インスタンスを2つ作成
resource "aws_instance" "AnsibleSV" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet_1.id
  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id # セキュリティグループIDを指定
    ]   
  associate_public_ip_address = true # パブリックIPアドレスを自動的に割り当て
  private_ip             = "10.0.1.10" # プライベートIPアドレスを指定

key_name               = aws_key_pair.my_key_pair.key_name

  tags = {
    Name = "public-subnet-1-instance-1"
  }
}

resource "aws_instance" "AppSV_01" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet_1.id
  vpc_security_group_ids = [
    aws_security_group.allow_http_https.id,
    aws_security_group.allow_ssh.id # セキュリティグループIDを指定
    ]  
  associate_public_ip_address = true
  private_ip             = "10.0.1.11" # プライベートIPアドレスを指定

key_name               = aws_key_pair.my_key_pair.key_name

  tags = {
    Name = "public-subnet-1-instance-2"
  }
}

# Public Subnet 2にEC2インスタンスを1つ作成
resource "aws_instance" "AppSV_02" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet_2.id
    vpc_security_group_ids = [
    aws_security_group.allow_http_https.id,
    aws_security_group.allow_ssh.id # セキュリティグループIDを指定
    ] 
  associate_public_ip_address = true 
  private_ip             = "10.0.2.11" # プライベートIPアドレスを指定

  tags = {
    Name = "public-subnet-2-instance"
  }
}

# Private Subnet 1にEC2インスタンスを1つ作成
resource "aws_instance" "DBSV_01" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private_subnet_1.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]  # セキュリティグループIDを指定
  private_ip             = "10.0.3.11" # プライベートIPアドレスを指定

key_name               = aws_key_pair.my_key_pair.key_name

  tags = {
    Name = "private-subnet-1-instance"
  }
}

# Private Subnet 2にEC2インスタンスを1つ作成
resource "aws_instance" "DBSV_02" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private_subnet_2.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]  # セキュリティグループIDを指定
  private_ip             = "10.0.4.11" # プライベートIPアドレスを指定

key_name               = aws_key_pair.my_key_pair.key_name
  tags = {
    Name = "private-subnet-2-instance"
  }
}