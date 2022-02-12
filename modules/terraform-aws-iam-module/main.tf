resource "aws_iam_role" "cloudwatch_role" {
  name = var.cloudwatch_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "cloudwatch_policy" {
  name = var.cloudwatch_policy_name
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:DescribeLogStreams",
                "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:*:*:log-group:${aws_cloudwatch_log_group.ec2_log_group.id}:*"
        }
    ]
})
}

resource "aws_iam_policy_attachment" "policy-attachment" {
  name       = var.policy_attachment_name
  roles      = ["${aws_iam_role.cloudwatch_role.id}"]
  policy_arn = "${aws_iam_policy.cloudwatch_policy.arn}"
}


//This is Cloud watch group
resource "aws_cloudwatch_log_group" "ec2_log_group" {
  name              = var.ec2_log_group_name
  retention_in_days = var.retention
}

resource "aws_iam_instance_profile" "iam_instance_profile" {
  name  = var.instance_profile_name
  role = "${aws_iam_role.cloudwatch_role.id}"
}