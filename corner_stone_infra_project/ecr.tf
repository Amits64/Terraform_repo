resource "aws_ecr_repository" "repositories" {
  for_each = toset(var.repository_names)

  name = each.value

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  encryption_configuration {
    encryption_type = var.encryption_type
  }
}
