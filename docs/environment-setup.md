# ShopSphere – Environment Setup

## 1. Project Overview
ShopSphere is an AWS DevOps End-to-End Capstone Project.

The project focuses on AWS Cloud, Docker, Kubernetes, Terraform, CI/CD, GitOps, and Monitoring.

## 2. Local Development Environment

Operating System: Windows 11

Code Editor: Visual Studio Code

Terminal: Windows PowerShell

## 3. Installed Tools

- Git
- Python
- Docker Desktop
- AWS CLI
- Terraform

## 4. Git Configuration

Git username: Teena

Git email: Configured locally

GitHub Repository: https://github.com/Teena123963/shopsphere-devops-capstone

Default Branch: main

## 5. AWS Configuration

AWS CLI Profile: shopsphere

AWS Region: ap-south-1

Authentication: IAM User Access Key

AWS Identity Verification:

```powershell
aws sts get-caller-identity
```

## 6. Project Folder Structure

- app/api
- app/frontend
- infra/terraform
- infra/ansible
- infra/docker
- serverless/lambda
- docs
- monitoring
- k8s

## 7. Git Commands

```powershell
git status
git add .
git commit -m "your commit message"
git push origin main
```

## 8. Security Notes

- Never upload AWS Access Keys or Secret Access Keys to GitHub.
- Never commit passwords or private keys.
- Keep sensitive configuration in environment variables.
- Keep Terraform state files out of Git.

## 9. Project Status

Initial Git repository setup completed.

AWS CLI identity verification successful.

First Git commit pushed to GitHub.