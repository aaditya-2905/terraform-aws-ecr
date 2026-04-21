resource "aws_ecr_repository" "private" {
  count = var.repository_type == "private" ? 1 : 0

  name         = var.name
  force_delete = var.force_delete

  dynamic "encryption_configuration" {
    for_each = var.encryption_config != null ? [1] : []
    content {
      encryption_type = var.encryption_config.encryption_type
      kms_key         = try(var.encryption_config.kms_key, null)
    }
  }

  dynamic "image_scanning_configuration" {
    for_each = var.image_scanning_config != null ? [1] : []
    content {
      scan_on_push = var.image_scanning_config.scan_on_push
    }
  }

  tags = var.tags
}

resource "aws_ecrpublic_repository" "public" {
  count = var.repository_type == "public" ? 1 : 0

  repository_name = var.name

  tags = var.tags
}

resource "aws_ecr_lifecycle_policy" "this" {
  count = var.lifecycle_policy != null && var.repository_type == "private" ? 1 : 0

  repository = aws_ecr_repository.private[0].name
  policy     = var.lifecycle_policy
}

resource "aws_ecr_repository_policy" "private" {
  count = var.repository_policy != null && var.repository_type == "private" ? 1 : 0

  repository = aws_ecr_repository.private[0].name
  policy     = var.repository_policy
}

resource "aws_ecrpublic_repository_policy" "public" {
  count = var.repository_policy != null && var.repository_type == "public" ? 1 : 0

  repository_name = aws_ecrpublic_repository.public[0].repository_name
  policy          = var.repository_policy
}
