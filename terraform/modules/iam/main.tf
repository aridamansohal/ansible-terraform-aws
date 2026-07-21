data "aws_iam_policy_document" "ansible_controller_policy" {

  statement {
    sid    = "AnsibleDynamicInventory"
    effect = "Allow"

    actions = [
      "ec2:DescribeInstances",
      "ec2:DescribeInstanceStatus",
      "ec2:DescribeTags",
      "ec2:DescribeRegions",
      "ec2:DescribeAvailabilityZones",
      "ssm:DescribeInstanceInformation"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "ansible_controller_policy" {
  name   = "ansible-controller-dynamic-inventory"
  policy = data.aws_iam_policy_document.ansible_controller_policy.json
}

data "aws_iam_role" "ec2_ssm_role" {
  name = "ec2-ssm-role"
}

resource "aws_iam_role_policy_attachment" "ansible_controller_policy" {
  role       = data.aws_iam_role.ec2_ssm_role.name
  policy_arn = aws_iam_policy.ansible_controller_policy.arn
}