# Fargate Profile for faster deployment (no EC2 wait time)
resource "aws_eks_fargate_profile" "bank_app" {
  cluster_name           = aws_eks_cluster.eks.name
  fargate_profile_name   = "${var.environment}-bank-app-fargate"
  pod_execution_role_arn = aws_iam_role.fargate_pod_execution_role.arn
  subnet_ids             = var.private_subnet_ids

  selector {
    namespace = "default"
  }

  selector {
    namespace = "bank-app"
  }

  selector {
    namespace = "argocd"
  }

  tags = {
    Name        = "${var.environment}-bank-app-fargate"
    Environment = var.environment
  }
}

# IAM Role for Fargate Pod Execution
resource "aws_iam_role" "fargate_pod_execution_role" {
  name = "${var.environment}-fargate-pod-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks-fargate-pods.amazonaws.com"
      }
    }]
  })

  tags = {
    Name        = "${var.environment}-fargate-pod-execution-role"
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "fargate_pod_execution_role_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.fargate_pod_execution_role.name
}
