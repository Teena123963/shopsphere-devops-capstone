

resource "aws_cloudwatch_log_group" "shopsphere_api" {
  name              = "/ecs/shopsphere-api"
  retention_in_days = 7

  tags = {
    Name    = "ShopSphere-API-Logs"
    Project = "ShopSphere"
  }
}

resource "aws_ecs_task_definition" "shopsphere_api" {
  family                   = "shopsphere-api"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512

  execution_role_arn = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {
      name      = "shopsphere-api"
      image     = "${aws_ecr_repository.shopsphere_api.repository_url}:latest"
      essential = true

      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
          protocol      = "tcp"
        }
      ]

      environment = [
        {
          name  = "DB_PORT"
          value = "5432"
        },
        {
          name  = "DB_HOST"
          value = aws_db_instance.shopsphere_postgres.address
        },
        {
          name  = "DB_NAME"
          value = aws_db_instance.shopsphere_postgres.db_name
        }
      ]

      secrets = [
        {
          name      = "DB_USER"
          valueFrom = "arn:aws:secretsmanager:ap-south-1:058416978799:secret:rds!db-e74906ae-664e-4f19-911d-242323107d6a-kliSDu:username::"
        },
        {
          name      = "DB_PASSWORD"
          valueFrom = "arn:aws:secretsmanager:ap-south-1:058416978799:secret:rds!db-e74906ae-664e-4f19-911d-242323107d6a-kliSDu:password::"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.shopsphere_api.name
          "awslogs-region"        = "ap-south-1"
          "awslogs-stream-prefix" = "ecs"
        }
      }

      healthCheck = {
        command = [
          "CMD-SHELL",
          "python -c \"import urllib.request; urllib.request.urlopen('http://127.0.0.1:5000/health', timeout=3)\""
        ]
        interval    = 30
        timeout     = 5
        retries     = 3
        startPeriod = 30
      }
    }
  ])

  depends_on = [
    aws_iam_role_policy_attachment.ecs_execution,
    aws_iam_role_policy.ecs_secrets_access
  ]

  tags = {
    Name    = "ShopSphere-API-Task-Definition"
    Project = "ShopSphere"
  }
}
