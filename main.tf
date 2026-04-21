module "ecr" {
  source = "./modules/ecr"

  name              = var.name
  repository_type   = var.repository_type
  force_delete      = var.force_delete
  encryption_config = var.encryption_config
  region            = var.region
  tags              = var.tags

  image_scanning_config = var.image_scanning_config

  repository_policy = var.repository_policy
  lifecycle_policy  = var.lifecycle_policy
}
