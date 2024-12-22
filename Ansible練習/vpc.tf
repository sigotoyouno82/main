# VPCの作成
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/21"  # VPCのCIDRブロック

  tags = {
    Name = "my-vpc"
  }
}

# インターネットゲートウェイの作成
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id  # VPCに関連付け

  tags = {
    Name = "my-internet-gateway"
  }
}

# パブリックサブネット1の作成
resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"  # パブリックサブネット1のCIDR
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "my-public-subnet-1"
  }
}

# パブリックサブネット2の作成
resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"  # パブリックサブネット2のCIDR
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "my-public-subnet-2"
  }
}

# プライベートサブネット1の作成
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.3.0/24"  # プライベートサブネット1のCIDR
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "my-private-subnet-1"
  }
}

# プライベートサブネット2の作成
resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.4.0/24"  # プライベートサブネット2のCIDR
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "my-private-subnet-2"
  }
}

# パブリックサブネット用のルートテーブルの作成
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my-public-route-table"
  }
}

# インターネットゲートウェイへのデフォルトルートを作成
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id
}

# パブリックサブネット1にルートテーブルを関連付け
resource "aws_route_table_association" "public_subnet_1_assoc" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

# パブリックサブネット2にルートテーブルを関連付け
resource "aws_route_table_association" "public_subnet_2_assoc" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

# NATゲートウェイ用のElastic IPを作成
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "my-nat-eip"
  }
}

# NATゲートウェイの作成
resource "aws_nat_gateway" "my_nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id  # パブリックサブネットに配置

  tags = {
    Name = "my-nat-gateway"
  }
}

# プライベートサブネット用のルートテーブルの作成
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my-private-route-table"
  }
}

# プライベートサブネット用のルートテーブルにNATゲートウェイへのデフォルトルートを設定
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.my_nat_gateway.id
}

# プライベートサブネット1にルートテーブルを関連付け
resource "aws_route_table_association" "private_subnet_1_assoc" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}

# プライベートサブネット2にルートテーブルを関連付け
resource "aws_route_table_association" "private_subnet_2_assoc" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id
}