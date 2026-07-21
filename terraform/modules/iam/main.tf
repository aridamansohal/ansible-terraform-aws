
################# iam policy  for controller to access dynamic inventory #################

resource "aws_iam_policy" "ansible_controller_policy" {
  name   = "ansible-controller-dynamic-inventory"
  policy = data.aws_iam_policy_document.ansible_controller_policy.json
}


resource "aws_iam_role_policy_attachment" "ansible_controller_policy" {
  role       = data.aws_iam_role.ec2_ssm_role.name
  policy_arn = aws_iam_policy.ansible_controller_policy.arn
}


################# iam policy  for controller to access s3 bucket #################

resource "aws_iam_policy" "ansible_controller_s3_policy" {
  name   = "ansible-controller-s3-access"
  policy = data.aws_iam_policy_document.ec2_ssm_s3_access.json
}



resource "aws_iam_role_policy_attachment" "ansible_controller_s3_policy" {
  role       = data.aws_iam_role.ec2_ssm_role.name
  policy_arn = aws_iam_policy.ansible_controller_s3_policy.arn
}


#################  s3 bucket policy to allow the ec2_role #################


resource "aws_s3_bucket_policy" "ansible_ssm" {
  bucket = data.aws_s3_bucket.ansible_ssm.id
  policy = data.aws_iam_policy_document.s3_bucket_policy.json
}

# Ansible SSM Session Policy for EC2 Role

resource "aws_iam_policy" "ansible-ssm-session-policy" {
  name   = "ansible-ssm-session-policy"
  policy = data.aws_iam_policy_document.ansible-ssm-session-policy.json
}


resource "aws_iam_role_policy_attachment" "ansible-ssm-session-policy" {
  role       = data.aws_iam_role.ec2_ssm_role.name
  policy_arn = aws_iam_policy.ansible-ssm-session-policy.arn
}
