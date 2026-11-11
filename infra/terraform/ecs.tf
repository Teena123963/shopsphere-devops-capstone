
resource "aws_ecs_cluster" "shopsphere" {
  name = "shopsphere-cluster"

  tags = {
    Name    = "ShopSphere-ECS-Cluster"
    Project = "ShopSphere"
  }
}
