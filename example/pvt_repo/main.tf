provider "aws" {
  region = "ap-south-1"
}

module "ecr_private" {
  source = "aaditya-2905/ecr/aws"

  name = "my-app-repo"

  repository_type = "private"
  force_delete    = true

  image_scanning_config = {
    scan_on_push = true
  }

  encryption_config = {
    encryption_type = "AES256"
  }

  lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 10 images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 10
        }
        action = {
          type = "expire"
        }
      }
    ]
  })

  repository_policy = jsonencode({
    Version = "2008-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ]
      }
    ]
  })

  tags = {
    Environment = "dev"
    Project     = "ecr-wrapper"
  }
}
