
resource "aws_ecs_service" "shopsphere_api" {
  name            = "shopsphere-api-service"
  cluster         = aws_ecs_cluster.shopsphere.id
  task_definition = aws_ecs_task_definition.shopsphere_api.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets = [
      aws_subnet.app_a.id,
      aws_subnet.app_b.id
    ]

    security_groups  = ["sg-071542af56b662dca"]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.shopsphere_api.arn
    container_name   = "shopsphere-api"
    container_port   = 5000
  }

  depends_on = [
    aws_lb_listener.shopsphere_http
  ]

  tags = {
    Name    = "ShopSphere-ECS-Service"
    Project = "ShopSphere"
  }
}
