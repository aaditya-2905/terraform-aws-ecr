variable "name" { type = string }
variable "repository_type" { type = string }

variable "force_delete" { type = bool }

variable "encryption_config" { type = any }
variable "region" { type = string }

variable "tags" { type = map(string) }

variable "image_scanning_config" { type = any }

variable "repository_policy" { type = string }
variable "lifecycle_policy" { type = string }
