variable "ansible_ssm" {
  type    = string
  default = "tf-sandbox-5f01"

}

variable "controller_role_arn" {
  type = string

}

variable "aws_region" {
  type = string
}