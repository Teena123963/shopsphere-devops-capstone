# ShopSphere – CI/CD Pipeline Documentation

## 1. Overview
ShopSphere uses GitHub Actions to automate application testing, Docker image building, and deployment to Amazon ECS Fargate.

## 2. CI/CD Workflow
Workflow file: `.github/workflows/deploy.yml`

The pipeline runs on:
- Push to the `main` branch.
- Pull requests targeting the `main` branch.

Pull requests run application tests. Pushes to `main` run tests and deployment.

## 3. Pipeline Steps

1. **Checkout:** GitHub Actions checks out the source code.
2. **Python Setup:** Python 3.12 is configured.
3. **Install Dependencies:** Application dependencies and pytest are installed.
4. **Automated Testing:** API tests are executed using pytest.
5. **AWS Authentication:** GitHub Actions assumes an AWS IAM role using OpenID Connect (OIDC). No long-lived AWS access keys are stored in GitHub.
6. **ECR Login:** GitHub Actions authenticates with Amazon Elastic Container Registry.
7. **Docker Build and Push:** The API Docker image is built and pushed to the `shopsphere-api` ECR repository. The Git commit SHA is used as the image tag.
8. **Task Definition Update:** The ECS task definition is updated with the new image.
9. **ECS Deployment:** The updated task definition is deployed to the `shopsphere-api-service` service in the `shopsphere-cluster` cluster.
10. **Stability Check:** The workflow waits for the ECS service to reach a stable state.

## 4. AWS Services Used

- AWS IAM – GitHub Actions OIDC role and permissions.
- Amazon ECR – Docker image storage.
- Amazon ECS – Container orchestration.
- AWS Fargate – Serverless container compute.
- GitHub Actions – CI/CD automation.

## 5. Deployment Configuration

- AWS Region: `ap-south-1`
- ECR Repository: `shopsphere-api`
- ECS Cluster: `shopsphere-cluster`
- ECS Service