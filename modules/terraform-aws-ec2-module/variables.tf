variable "ami_id" {
  type    = string
  default = "ami-0ed9277fb7eb570c9"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "associate_public_ip" {
  type    = bool
  default = true
}
variable "availability_zone" {
  type    = string
  default = "us-east-1a"
}
variable "key" {
  type    = string
  default = "dev-account"
}

variable "security_group_ids" {
  type    = list(any)
  default = ["sg-0858149edde4ae5ae"]
}

variable "subnet_id" {
  type    = string
  default = "subnet-03a2ea8c56ec8a1f2"
}

variable "user_data" {
  type    = string
  default = "server_name"
}

variable "target_id" {
  type    = string
  default ="targetid"
}

variable "target_group" {
  type    = string
  default ="targetgroup"
}

variable "instance_profile" {
  type    = string
  default ="cloudwatch_log_instance_profilef"
}

variable "instance_name" {
  type    = string
  default ="ec2_instance_name"
}