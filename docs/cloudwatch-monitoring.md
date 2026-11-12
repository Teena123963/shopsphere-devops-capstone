# ShopSphere – CloudWatch Monitoring

## 1. Objective

Configure Amazon CloudWatch monitoring for the ShopSphere application to monitor ECS, ALB, RDS and Lambda resources and receive email notifications for high ECS CPU utilization.

## 2. ECS CloudWatch Logs

- Log Group: `/ecs/shopsphere-api`
- Retention: 7 days
- Log Driver: `awslogs`
- Region: `ap-south-1`
- Container: `shopsphere-api`

Example application log entries:

```text
[INFO] Starting gunicorn 23.0.0
[INFO] Listening at: http://0.0.0.0:5000
[INFO] Using worker: sync
[INFO] Booting worker
```

ECS application logs were successfully verified in CloudWatch Logs.

## 3. CloudWatch Dashboard

Dashboard Name: `shopsphere-monitoring`

The dashboard includes:

1. ECS CPU utilization and memory utilization.
2. ECS running task count.
3. ALB request count.
4. ALB target response time.
5. ALB healthy and unhealthy host count.
6. RDS CPU utilization and database connections.
7. Lambda errors.
8. Lambda execution duration.

Note: Running task count uses the Container Insights metric. Data availability depends on Container Insights being enabled.

## 4. ECS CPU Alarm

- Alarm Name: `shopsphere-high-ecs-cpu`
- Namespace: `AWS/ECS`
- Metric: `CPUUtilization`
- Cluster: `shopsphere-cluster`
- Service: `shopsphere-api-service`
- Threshold: Greater than 80%
- Period: 300 seconds (5 minutes)
- Evaluation Periods: 1
- Missing Data: Not breaching
- Current State: OK
- Actions Enabled: True

## 5. SNS Email Notification

- SNS Topic: `shopsphere-alerts`
- Region: `ap-south-1`
- Protocol: Email
- Subscription: Confirmed
- Email Notification Test: Successful

The SNS topic is connected to the ECS CPU alarm.

## 6. Notification Testing

A controlled notification test was performed using the CloudWatch SetAlarmState command.

The notification email was successfully received.

No artificial CPU load was generated on the production ECS service.

After the test, CloudWatch evaluated the alarm again and its state returned to OK.

## 7. Incident Investigation Report

### Incident: CloudFront API requests returned HTTP 504

**Problem:**
CloudFront API requests were returning HTTP 504 errors.

**Investigation:**
The ALB security group did not allow HTTP traffic from CloudFront origin-facing IP ranges.

**Root Cause:**
The ALB security group allowed only specific client IP addresses and did not include the CloudFront origin-facing managed prefix list.

**Resolution:**
Added the AWS-managed CloudFront origin-facing prefix list `pl-9aa247f3` to the ALB security group for TCP port 80.

**Verification:**
- CloudFront frontend returned HTTP 200.
- `/products` returned HTTP 200 with product JSON.
- `/health` returned HTTP 200 with application health status.

**Result:** API connectivity was restored successfully.

## 8. Troubleshooting Notes

- If ECS logs are missing, verify the task definition's `awslogs` configuration and log group.
- If an alarm has no data, verify metric namespace, dimensions and resource activity.
- If email notifications are missing, verify SNS subscription confirmation and alarm actions.
- If CloudFront returns 504, check ALB security group rules and target health.

## 9. Final Outcome

CloudWatch dashboard, ECS application logging, CPU alarm and SNS email notification have been configured and verified for the ShopSphere project.