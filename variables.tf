variable "name" {
  type = string
}

variable "repository_type" {
  description = "private or public"
  type        = string
  default     = "private"
}

variable "force_delete" {
  type    = bool
  default = false
}

variable "encryption_config" {
  type = object({
    encryption_type = string
    kms_key         = optional(string)
  })
  default = null
}

variable "region" {
  type    = string
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "image_scanning_config" {
  type = object({
    scan_on_push = bool
  })
  default = null
}

variable "repository_policy" {
  type    = string
  default = null
}

variable "lifecycle_policy" {
  type    = string
  default = null
}
