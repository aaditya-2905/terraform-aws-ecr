output "repository_url" {
  value = var.repository_type == "private" ? aws_ecr_repository.private[0].repository_url : aws_ecrpublic_repository.public[0].repository_uri
}

output "repository_arn" {
  value = var.repository_type == "private" ? aws_ecr_repository.private[0].arn : aws_ecrpublic_repository.public[0].arn
}
