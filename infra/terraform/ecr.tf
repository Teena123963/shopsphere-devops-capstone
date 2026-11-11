
resource "aws_ecr_repository" "shopsphere_api" {
  name                 = "shopsphere-api"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Name    = "ShopSphere-API-ECR"
    Project = "ShopSphere"
  }
}
