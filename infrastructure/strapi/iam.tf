
resource "aws_iam_instance_profile" "this" {
  name = "strapi-ec2-profile"
  role = aws_iam_role.strapi-role.name
}

resource "aws_iam_role" "strapi-role" {
  name               = "strapi-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "strapi-role-policy-attachment" {
  role       = aws_iam_role.strapi-role.name
  policy_arn = data.aws_iam_policy.AmazonSSMManagedInstanceCore.arn
}

resource "aws_iam_role_policy_attachment" "strapi-role-policy-attachment-2" {
  role       = aws_iam_role.strapi-role.name
  policy_arn = data.aws_iam_policy.CloudWatchAgentServerPolicy.arn
}
