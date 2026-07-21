

data "aws_iam_policy_document" "ansible_controller_policy" {

  statement {
    sid    = "AnsibleDynamicInventory"
    effect = "Allow"

    actions = local.actions

    resources = ["*"]
  }
}


data "aws_iam_role" "ec2_ssm_role" {
  name = "ec2-ssm-role"
}


data "aws_caller_identity" "current" {}



data "aws_s3_bucket" "ansible_ssm" {
  bucket = var.ansible_ssm

}
##################################### IAM policy to access S3 Bucket via ec2 role#############

data "aws_iam_policy_document" "ec2_ssm_s3_access" {
  statement {
    sid    = "AllowAnsibleSSMAccess"
    effect = "Allow"

    actions = local.s3_actions

    resources = [
      data.aws_s3_bucket.ansible_ssm.arn,
      "${data.aws_s3_bucket.ansible_ssm.arn}/*"
    ]
  }
}


################## Bucket policy to allow the controller role #########
data "aws_iam_policy_document" "s3_bucket_policy" {
  statement {
    sid    = "AllowControllerRole"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [var.controller_role_arn]
    }

    actions = [
      "s3:GetBucketLocation",
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      data.aws_s3_bucket.ansible_ssm.arn,
      "${data.aws_s3_bucket.ansible_ssm.arn}/*"
    ]
  }
}


##################
data "aws_iam_policy_document" "ansible-ssm-session-policy" {
  statement {
    sid    = "AllowSSMSessions"
    effect = "Allow"

    actions = local.ssm-session-actions

    resources = ["*"]
  }
}
