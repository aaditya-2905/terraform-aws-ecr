provider "aws" {
  region = "us-east-1" # IMPORTANT
}

module "ecr_public" {
  source = "aaditya-2905/ecr/aws"

  name            = "my-public-repo"
  repository_type = "public"

  repository_policy = jsonencode({
    Version = "2008-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action = [
          "ecr-public:GetDownloadUrlForLayer",
          "ecr-public:BatchGetImage"
        ]
      }
    ]
  })

  tags = {
    Visibility = "public"
  }
}
