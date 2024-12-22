#EC2用の環境変数
variable "ami_id" {
  default = "ami-01ae6169b82b38e3b"  # 東京リージョン (ap-northeast-1)
}

variable "instance_type" {
  default = "t2.micro"  # 最も低コストなインスタンスタイプ
}