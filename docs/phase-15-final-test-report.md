# ShopSphere – Phase 15 Final Test Report

**Project:** ShopSphere AWS DevOps Capstone
**Date:** 13 November 2026
**AWS Region:** ap-south-1

## 1. Kubernetes Pod Recovery
- Status: PASS
- Failed pod recovery tested.
- Replacement pod successfully reached 1/1 Running.

## 2. Kubernetes Deployment Validation
- Deployment health verification: Pending final verification.

## 3. AWS Security Review
- Status: PASS
- RDS security group reviewed.
- Application and IAM security reviewed.
- Default VPC cleanup completed.
- 23 launch-wizard security groups deleted.
- S3 Public Access Block verified for four buckets.
- Account-level S3 Public Access Block enabled.

## 4. Application Security
- Database password in infra/docker/compose.yaml requires remediation.
- HTTPS port 443 verification pending.

## 5. AWS Cost Review
- Cost review performed.
- NAT Gateway, EC2, RDS and ALB resources intentionally retained.
- Resources will be deleted after project submission.

## 6. Final Status
Testing and security review completed; remaining improvements documented.

## 7. Conclusion
ShopSphere infrastructure, application, Kubernetes recovery,
serverless workflow and monitoring work have been documented.
Remaining security and validation items must be completed
before final project submission.
