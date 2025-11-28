# Create IAM role for GitHub runner EC2 instance
resource "aws_iam_role" "github_runner_role" {
  name = "github-runner-ecr-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "GitHub Runner ECR Role"
  }
}

# Policy for ECR push/pull
resource "aws_iam_role_policy" "github_runner_ecr_policy" {
  name = "github-runner-ecr-policy"
  role = aws_iam_role.github_runner_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:BatchGetImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:PutImage"
        ]
        Resource = "*"
      }
    ]
  })
}

# Create instance profile
resource "aws_iam_instance_profile" "github_runner_profile" {
  name = "github-runner-instance-profile"
  role = aws_iam_role.github_runner_role.name
}

# Attach the instance profile to existing EC2 instance
resource "aws_ec2_instance_state" "github_runner_instance" {
  instance_id = "i-0dee94cca795b129e"
  state       = "running"
}

# Note: To attach IAM role to existing instance, we need to use AWS CLI or console
# Run this command after terraform apply:
# aws ec2 associate-iam-instance-profile --instance-id i-0dee94cca795b129e --iam-instance-profile Name=github-runner-instance-profile --region us-east-1

output "iam_role_name" {
  value = aws_iam_role.github_runner_role.name
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.github_runner_profile.name
}

output "attach_role_command" {
  value = "aws ec2 associate-iam-instance-profile --instance-id i-0dee94cca795b129e --iam-instance-profile Name=${aws_iam_instance_profile.github_runner_profile.name} --region us-east-1"
}
