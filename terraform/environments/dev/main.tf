module "iam_roles" {
  source              = "../../modules/iam"
  controller_role_arn = var.controller_role_arn
  aws_region          = var.aws_region

}


