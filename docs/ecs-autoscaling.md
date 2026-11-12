
# ECS Fargate Auto Scaling — ShopSphere

## Objective
Configure automatic scaling for the ShopSphere ECS Fargate service based on CPU utilization.

## ECS Service Details
- Cluster: shopsphere-cluster
- Service: shopsphere-api-service
- Region: ap-south-1

## Auto Scaling Configuration
- Minimum capacity: 1 task
- Maximum capacity: 3 tasks
- Scaling policy: Target Tracking
- Metric: ECSServiceAverageCPUUtilization
- Target CPU utilization: 60%
- Scale-out cooldown: 60 seconds
- Scale-in cooldown: 120 seconds

## Application Load Balancer Health
- Target Group: shopsphere-api-tg
- Target Port: 5000
- Target Health: healthy
- Availability Zone: ap-south-1a

## Verification
ECS Auto Scaling target and scaling policy were verified using AWS CLI.

ALB target health was verified using describe-target-health.

## Result
ECS Fargate Auto Scaling was configured successfully. The ALB target is healthy.
