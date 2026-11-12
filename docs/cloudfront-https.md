# ShopSphere – Phase 10: CloudFront, HTTPS and CDN Configuration

## 1. Objective

The objective of this phase is to distribute the ShopSphere frontend using Amazon CloudFront and provide secure HTTPS access to the application.

CloudFront is used as a Content Delivery Network (CDN) to improve application delivery and route API requests to the backend.

## 2. Frontend S3 Bucket

An Amazon S3 bucket was created to store the ShopSphere frontend application.

- Bucket Name: shopsphere-frontend-dev-058416978799
- AWS Region: ap-south-1
- Frontend File: index.html
- Versioning: Enabled
- Server-side Encryption: AES256
- Block Public Access: Enabled

The frontend is uploaded to a private S3 bucket. Public access is not allowed.

## 3. CloudFront Origin Access Control (OAC)

An Origin Access Control (OAC) was created to allow CloudFront to securely access the private S3 bucket.

- OAC Name: shopsphere-frontend-oac
- OAC ID: E28G1K04J5HIMF
- Signing Protocol: SigV4
- Signing Behavior: Always
- Origin Type: S3

The S3 bucket policy allows access to the configured CloudFront distribution.

## 4. CloudFront Distribution

- Distribution ID: EGM6C4G7QQZ2D
- Distribution Domain: d20bnjdu3wnian.cloudfront.net
- AWS Region for application resources: ap-south-1
- Default Root Object: index.html
- HTTP Version: HTTP/2
- Deployment Status: Deployed

## 5. CloudFront Origins

### Frontend Origin – Amazon S3

- Origin: shopsphere-frontend-dev-058416978799.s3.ap-south-1.amazonaws.com
- Purpose: Serves static frontend files.
- Access: Secured using OAC.

### Backend Origin – Application Load Balancer

- Origin: shopsphere-alb-443208633.ap-south-1.elb.amazonaws.com
- Protocol: HTTP
- Port: 80
- Purpose: Forwards API requests to the backend application hosted on Amazon ECS Fargate.

## 6. CloudFront Cache Behaviors

| Path Pattern | Origin | Purpose |
|---|---|---|
| Default (*) | S3 | Frontend website |
| /products* | ALB | Product API |
| /orders* | ALB | Order API |
| /health* | ALB | Health check API |

API behaviors allow the required HTTP methods and forward headers and cookies. API caching is disabled using zero TTL values.

The default frontend behavior redirects HTTP requests to HTTPS.

## 7. ALB Security Group Configuration

Initially, CloudFront API requests returned 504 Gateway Timeout errors because the ALB Security Group allowed HTTP traffic only from specific IP addresses.

The issue was fixed by allowing the AWS-managed CloudFront origin-facing prefix list.

- ALB Security Group: sg-0c8b43c25da2b75cd
- Prefix List: pl-9aa247f3
- Protocol: TCP
- Port: 80
- Security Group Rule ID: sgr-05a27941b6458ea19

This allows CloudFront origin-facing traffic without opening port 80 to all public IP addresses.

## 8. HTTPS Configuration

CloudFront's default domain provides HTTPS using the CloudFront default certificate.

- HTTPS: Enabled through CloudFront
- Viewer Protocol Policy: Redirect HTTP to HTTPS
- Custom Domain: Not configured
- Route 53 Hosted Zone: Not configured
- Custom ACM Certificate: Not configured

A custom domain was not available for this project, so the CloudFront default domain is used.

## 9. Frontend and Backend Integration

The frontend application integrates with the following backend APIs:

- GET /products – Retrieves product information.
- POST /orders – Submits customer orders.
- GET /health – Checks backend application health.

CloudFront routes these API requests to the ALB origin, which forwards traffic to the ECS Fargate backend.

## 10. Verification and Testing Results

CloudFront deployment completed successfully.

| Test | Result |
|---|---|
| CloudFront distribution deployment | Deployed |
| Frontend HTTPS access | HTTP 200 OK |
| Products API | HTTP 200 OK |
| Health API | HTTP 200 OK |
| ALB to ECS backend connectivity | Successful |
| Frontend order submission | Tested |

### Products API Response

```json
[
  {"id": 1, "name": "Laptop", "price": 55000},
  {"id": 2, "name": "Mobile", "price": 25000}
]
```

### Health API Response

```json
{"status": "ok"}
```

### Application URL

https://d20bnjdu3wnian.cloudfront.net

## 11. Outcome

The ShopSphere frontend is hosted in a private S3 bucket and delivered through CloudFront using HTTPS.

CloudFront securely accesses the S3 frontend through OAC and forwards API requests to the ALB and ECS Fargate backend.

Frontend and API connectivity tests returned successful HTTP 200 responses. The order submission flow was also tested.

Custom domain, Route 53 and custom ACM certificate configuration were not included because no custom domain was available.