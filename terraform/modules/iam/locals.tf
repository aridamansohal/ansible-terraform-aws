locals {
  actions = [
    "ec2:DescribeInstances",
    "ec2:DescribeInstanceStatus",
    "ec2:DescribeTags",
    "ec2:DescribeRegions",
    "ec2:DescribeAvailabilityZones",
    "ssm:DescribeInstanceInformation"
  ]

  s3_actions = [
    "s3:GetBucketLocation",
    "s3:ListBucket",
    "s3:GetObject",
    "s3:PutObject",
    "s3:DeleteObject"
  ]

#   resources = [
#     "arn:aws:ec2:${var.aws_region}:${data.aws_caller_identity.current.account_id}:instance/*",

#     "arn:aws:ssm:${var.aws_region}::document/SSM-SessionManagerRunShell"
#   ]

  ssm-session-actions = [
    "ssm:StartSession",
    "ssm:ResumeSession",
  "ssm:TerminateSession"]

}