output "fargate_profile_name" {
  value = aws_eks_fargate_profile.production.fargate_profile_name
}

output "pod_execution_role_arn" {
  value = aws_iam_role.eks_fargate_pod_execution_role.arn
}
