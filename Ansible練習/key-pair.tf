# 公開鍵を使ってAWSのキーペアを作成
resource "aws_key_pair" "my_key_pair" {
  key_name   = "my-aws-key"  # キーペアの名前
  public_key = file("/Users/awanohayato/.ssh/my-aws-key.pub")  # 公開鍵のファイルパスを指定

  tags = {
    Name = "my-aws-key"
  }
}
