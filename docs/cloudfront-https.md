# ShopSphere – Phase 10: CloudFront, HTTPS and CDN Configuration

## 1. Objective

The objective of this phase is to distribute the ShopSphere frontend using Amazon CloudFront and provide secure HTTPS access to the application.

CloudFront is used as a Content Delivery Network (CDN) to improve application delivery and route API requests to the backend.

## 2. Frontend S3 Bucket

An Amazon S3 bucket was created to store the ShopSphere frontend application.

- **Bucket Name:** shopsphere-frontend-dev-058416978799
- **AWS Region:** ap-south-1
- **Frontend File:** index.html
- **Versioning:** Enabled
- **Server-side Encryption:** AES256
- **Block Public Access:** Enabled

The frontend is uploaded to a private S3 bucket. Public access is not allowed.

## 3. CloudFront Origin Access Control (OAC)

An Origin Access Control (OAC) was created to allow CloudFront to securely access the private S3 bucket.

- **OAC Name:** shopsphere-frontend-oac
- **OAC ID:** E28G1K04J5HIMF
- **Signing Protocol:** SigV4
- **Signing Behavior:** Always
- **Origin Type:** S3

The S3 bucket policy allows access only to the configured CloudFront distribution.

## 4. CloudFront Distribution

A CloudFront distribution was created for the ShopSphere application.

- **Distribution ID:** EGM6C4G7QQZ2D
- **Distribution Domain:** d20bnjdu3wnian.cloudfront.net
- **AWS Account:** 058416978799
- **Default Root Object:** index.html
- **HTTP Version:** HTTP/2

**Current deployment status:** InProgress (deployment is still running; final status must be verified).

## 5. CloudFront Origins

Two origins are configured:

### Frontend Origin – Amazon S3

- **Origin:** shopsphere-frontend-dev-058416978799.s3.ap-south-1.amazonaws.com
- **Purpose:** Serves the static frontend files.
- **Access:** Secured using OAC.

### Backend Origin – Application Load Balancer

- **Origin:** shopsphere-alb-443208633.ap-south-1.elb.amazonaws.com
- **Protocol:** HTTP
- **Port:** 80
- **Purpose:** Forwards frontend API requests to the backend application hosted on Amazon ECS Fargate.

## 6. Cache Behaviors

The following path patterns are configured:

| Path Pattern | Origin | Purpose |
|---|---|---|
| Default (*) | S3 | Frontend website |
| /products* | ALB | Product API |
| /orders* | ALB | Order API |
| /health* | ALB | Health check API |

The API behaviors allow all required HTTP methods and forward headers and cookies. API caching is disabled using zero TTL values so that dynamic API responses are not served from cache.

The default frontend behavior