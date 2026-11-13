# shopsphere-devops-capstone
AWS DevOps End-to-End Capstone Project
# ShopSphere – AWS DevOps End-to-End Capstone Project

A hands-on AWS DevOps capstone project demonstrating cloud infrastructure, containerization, serverless computing, Kubernetes deployment, and infrastructure management.

---

## 1. Project Overview

ShopSphere is an e-commerce application developed as an AWS DevOps End-to-End Capstone Project.

The project demonstrates practical implementation of AWS networking, EC2, Docker, PostgreSQL, Lambda, Step Functions, Kubernetes, Terraform, and monitoring tools.

The application supports product listing, order creation, and order validation.

## 2. Architecture Overview

### Application Architecture

```text
                  SHOPSPHERE APPLICATION
                            |
                       Flask REST API
                            |
                   Docker / Gunicorn
                            |
                     PostgreSQL DB
                            |
                     Order Creation
                            |
                   AWS Lambda Function
                            |
                    AWS Step Functions
                            |
                    Order Validation

              AWS INFRASTRUCTURE
                            |
                     Amazon VPC
                            |
                 Public and Private Subnets
                            |
               Internet Gateway / NAT Gateway
                            |
                         EC2
                            |
                   AWS Systems Manager

             CONTAINER ORCHESTRATION
                            |
                       Kubernetes
                            |
                   ShopSphere Namespace
                            |
                     Application Pods

             INFRASTRUCTURE MANAGEMENT
                            |
                        Terraform
                            |
                Prometheus / Grafana
```

### Main Components

- AWS networking infrastructure
- EC2 instance with secure SSM access
- Flask backend API
- PostgreSQL database
- Docker and Docker Compose
- AWS Lambda and Step Functions
- Kubernetes application deployment
- Terraform configuration
- Prometheus and Grafana monitoring documentation

## 3. Technologies and AWS Services

| Category | Technologies / Services |
|---|---|
| Cloud Provider | Amazon Web Services |
| Networking | VPC, Subnets, Internet Gateway, NAT Gateway |
| Compute | Amazon EC2 |
| Access Management | IAM, Systems Manager |
| Backend | Python, Flask, Gunicorn |
| Database | PostgreSQL 16 |
| Containerization | Docker, Docker Compose |
| Serverless | AWS Lambda |
| Workflow Orchestration | AWS Step Functions |
| Container Orchestration | Kubernetes |
| Package Management | Helm |
| Infrastructure as Code | Terraform |
| Monitoring | Prometheus, Grafana |
| Version Control | Git, GitHub |

## 4. Repository Structure

```text
shopsphere-devops-capstone/
|
├── app/
│   └── api/
│       ├── Flask application
│       ├── Dockerfile
│       └── application dependencies
|
├── infra/
│   ├── docker/
│   │   └── compose.yaml
│   └── terraform/
│       └── Infrastructure configuration
|
├── serverless/
│   └── lambda/
│       └── validate_order.py
|
├── k8s/
│   ├── Kubernetes deployment files
│   └── Kubernetes service files
|
├── monitoring/
│   └── Monitoring documentation
|
├── docs/
│   └── Project documentation and evidence
|
└── README.md
```

## 5. End-to-End Implementation

### Phase 1 – AWS Networking

- Created a custom AWS VPC.
- Configured public, application, and database subnets.
- Used two Availability Zones.
- Created and attached an Internet Gateway.
- Configured a NAT Gateway.
- Configured route tables.
- Created separate Security Groups for different application tiers.

### Phase 2 – EC2 and Secure Access

- Created an EC2 instance.
- Configured an IAM role.
- Attached AmazonSSMManagedInstanceCore policy.
- Configured AWS Systems Manager Session Manager access.

### Phase 3 – Docker and Application Development

- Developed a Flask REST API.
- Configured Gunicorn as the application server.
- Integrated PostgreSQL database.
- Created Dockerfile and Docker Compose configuration.
- Used PostgreSQL 16 as the database container.

### Phase 4 – API and Database Testing

Tested the following application endpoints:

- `/health` – Application health check.
- `/products` – Retrieve product information.
- Order creation – Create an order using product ID and quantity.

Verified order data in PostgreSQL.

### Phase 5 – AWS Lambda

- Created the `shopsphere-validate-order` Lambda function.
- Implemented order validation logic.
- Created a deployment package.
- Tested valid order input successfully.

### Phase 6 – AWS Step Functions

- Created the `shopsphere-order-validation` state machine.
- Integrated the Lambda function.
- Configured workflow success and failure handling.
- Executed and verified a successful workflow.

### Phase 7 – Kubernetes Deployment

- Configured the Kubernetes namespace `shopsphere`.
- Deployed ShopSphere application pods.
- Verified pod status and readiness.
- Checked application deployment and pod health.

### Phase 8 – Terraform and Monitoring

- Organized Terraform infrastructure configuration.
- Maintained infrastructure as code files.
- Prepared Prometheus and Grafana monitoring documentation.

## 6. Docker and Deployment Configuration

Docker Compose is used to run the Flask API and PostgreSQL database together.

Configuration file:

`infra/docker/compose.yaml`

### Start Application

```bash
docker compose -f infra/docker/compose.yaml up --build -d
```

### Check Containers

```bash
docker ps
```

### Stop Application

```bash
docker compose -f infra/docker/compose.yaml down
```

## 7. Testing and Validation

| Test Case | Expected / Observed Result | Status |
|---|---|---|
| Flask Health Check | `/health` returned OK | Passed |
| Product API | Product information retrieved | Passed |
| Order Creation | Order created successfully | Passed |
| PostgreSQL Verification | Order record verified in database | Passed |
| Lambda Validation | Valid order returned validated status | Passed |
| Step Functions | Execution completed successfully | Passed |
| Kubernetes Pods | Application pods reached Running and Ready | Verified |

## 8. GitHub and Version Control

Git and GitHub are used for source code management and project version control.

### Git Workflow

```bash
git status
git add .
git commit -m "Update ShopSphere project"
git push origin main
```

The repository maintains application code, infrastructure configuration, Kubernetes resources, serverless code, and available project documentation.

Note: Git-based version control is implemented. An automated GitHub Actions deployment pipeline is not claimed as completed.

## 9. Security Highlights

- Used IAM roles for AWS service permissions.
- Configured Systems Manager for secure EC2 access.
- Separated application and database network security groups.
- Restricted database access through security group rules.
- Configured AWS account-level S3 public access blocking.
- Used private application and database subnet architecture in the VPC design.

## 10. Challenges and Solutions

| Challenge | Solution |
|---|---|
| Secure EC2 access | Configured Systems Manager |
| Docker and database integration | Used Docker Compose |
| Lambda module import error | Corrected Lambda deployment package |
| API testing | Tested application endpoints |
| Database verification | Checked PostgreSQL records |
| Kubernetes pod monitoring | Used kubectl commands |
| Workflow execution | Verified Step Functions execution |

## 11. Project Repository

**GitHub Repository:**

https://github.com/Teena123963/shopsphere-devops-capstone

The repository contains project source code, Terraform configuration, Docker files, Kubernetes resources, Lambda code, and available documentation.

## 12. Conclusion

The ShopSphere project provided practical experience with AWS cloud infrastructure, networking, application development, containerization, serverless computing, Kubernetes, and infrastructure management.

It demonstrates the use of multiple DevOps tools and AWS services to build and test an e-commerce application.

**Project Name:** ShopSphere – AWS DevOps End-to-End Capstone Project

**Project Type:** AWS DevOps Capstone Project