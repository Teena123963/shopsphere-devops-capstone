
# ShopSphere Kubernetes Deployment

## Environment
- Kubernetes: Docker Desktop
- Namespace: shopsphere
- Application: shopsphere-api
- Container Port: 5000
- Service Type: ClusterIP
- Replicas: 2

## Kubernetes Resources
- Deployment: shopsphere-api
- Service: shopsphere-api
- ConfigMap: shopsphere-config
- Image: AWS ECR

## Health Checks
- Readiness Probe: /health
- Liveness Probe: /health

## Resource Configuration
- CPU Request: 100m
- Memory Request: 128Mi
- CPU Limit: 500m
- Memory Limit: 512Mi

## Testing
- GET /health: Successful
- GET /products: Successful
- APP_ENV: dev

## Scaling and Recovery
- Scaled replicas from 2 to 3.
- Deleted one test Pod.
- Kubernetes automatically created a replacement Pod.
- Verified all 3 Pods were Running.
- Updated Deployment to 2 replicas.

## Result
ShopSphere API successfully deployed on Kubernetes.
Deployment, Service, ConfigMap, health checks,
scaling and automatic Pod recovery verified.
