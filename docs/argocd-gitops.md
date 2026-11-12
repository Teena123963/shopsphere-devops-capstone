# ShopSphere Argo CD GitOps

## Environment
- Kubernetes: Docker Desktop
- GitOps Tool: Argo CD
- Namespace: argocd
- Application Namespace: shopsphere

## Git Repository
- Repository: shopsphere-devops-capstone
- Branch: main
- Manifest Path: k8s

## Argo CD Configuration
- Application: shopsphere
- Automated Sync: Enabled
- Self Heal: Enabled
- Prune: Disabled
- Destination: Kubernetes in-cluster

## Deployment
- Application: shopsphere-api
- Desired Replicas: 3
- Container Image: AWS ECR

## Verification
- GitHub repository connected successfully.
- Argo CD application status: Synced.
- Argo CD application health: Healthy.
- GitHub commit e92aff6 pushed successfully.
- Deployment scaled from 2 to 3 through GitOps.
- All 3 replicas verified as Available.
- Manual scaling drift tested.
- Argo CD automatically restored replicas to 3.

## Result
ShopSphere GitOps successfully configured using Argo CD and GitHub.

Automated Sync and Self-Heal functionality verified successfully.