# Terraform AWS ECR Module

A **scalable, enterprise-grade Terraform module** to provision and manage AWS Elastic Container Registry (ECR) repositories.

Supports both:

* 🔒 Private repositories (for ECS, EKS, CI/CD)
* 🌍 Public repositories (for open distribution)

---

## 🚀 Features

* ✅ Supports **private and public repositories**
* ✅ Fully **optional inputs** (beginner-friendly)
* ✅ Explicit variables (no hidden abstraction)
* ✅ Image scanning support
* ✅ Encryption configuration (private only)
* ✅ Lifecycle policies (private only)
* ✅ Repository policies (public + private)
* ✅ Clean module structure (root + internal)

---

## 🧱 Module Structure

```
terraform-aws-ecr/
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
└── modules/
    └── ecr/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

---

## ⚙️ Usage

---

### 🔒 Private Repository Example

```hcl
module "ecr_private" {
  source = "aaditya-2905/ecr/aws"

  name = "my-app"

  image_scanning_config = {
    scan_on_push = true
  }

  tags = {
    Environment = "dev"
  }
}
```

---

### 🌍 Public Repository Example

```hcl
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
}
```

---

## 📦 Inputs

| Name                  | Description                        | Type        | Default   |
| --------------------- | ---------------------------------- | ----------- | --------- |
| name                  | Repository name                    | string      | required  |
| repository_type       | `private` or `public`              | string      | `private` |
| force_delete          | Force delete images                | bool        | false     |
| encryption_config     | Encryption settings (private only) | object      | null      |
| image_scanning_config | Scan images on push                | object      | null      |
| repository_policy     | JSON repository policy             | string      | null      |
| lifecycle_policy      | Lifecycle policy (private only)    | string      | null      |
| region                | AWS region                         | string      | null      |
| tags                  | Tags                               | map(string) | `{}`      |

---

## 📤 Outputs

| Name           | Description    |
| -------------- | -------------- |
| repository_url | Repository URL |
| repository_arn | Repository ARN |

---

## 🔐 Private vs Public

| Feature          | Private Repo | Public Repo     |
| ---------------- | ------------ | --------------- |
| Access Control   | IAM          | Public          |
| Encryption       | ✅ Supported  | ❌ Not supported |
| Lifecycle Policy | ✅ Supported  | ❌ Not supported |
| Region           | Any          | us-east-1 only  |

---

## ⚠️ Important Notes

* Public ECR repositories work only in **us-east-1**
* Lifecycle policies apply only to private repositories
* Encryption is only supported for private repositories
* Ensure correct IAM permissions for push/pull

---

## 🚀 Best Practices

* Enable **image scanning** for security
* Use lifecycle policies to clean old images
* Avoid public access unless necessary
* Use tags for better resource tracking

---

## 🧪 Supported Use Cases

* ECS / EKS deployments
* CI/CD pipelines
* Private container registries
* Public container image distribution

---

## 📈 Future Improvements

* Cross-region replication
* Pull-through cache support
* Advanced access policies
* Integration with CI/CD tools

---

## 🤝 Contributing

Contributions are welcome:

* Improve variable typing
* Add validation rules
* Extend feature support

---

## 📄 License

MIT License