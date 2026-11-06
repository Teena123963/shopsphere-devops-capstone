
# ShopSphere - Security Groups Documentation

## Security Groups

| Security Group | ID | Purpose |
|---|---|---|
| ALB-SG | sg-0c8b43c25da2b75cd | Load Balancer access |
| APP-SG | sg-071542af56b662dca | Application access |
| DB-SG | sg-05ad59980055a9106 | Database access |
| ADMIN-SG | sg-06e3362a81591e07f | Administration |
| Default SG | sg-051c4565f7b3ab027 | Default VPC security group |

## Inbound Rules

| Security Group | Protocol / Port | Source |
|---|---|---|
| ALB-SG | TCP 80 | Configured public IP (/32) |
| APP-SG | TCP 5000 | ALB-SG |
| DB-SG | TCP 5432 | APP-SG |
| ADMIN-SG | No inbound rules | None |

## Security Design

- ALB traffic is restricted to the configured public IP.
- Application traffic on port 5000 is allowed only from ALB-SG.
- PostgreSQL traffic on port 5432 is allowed only from APP-SG.
- ADMIN-SG has no inbound access; administration is planned through AWS Systems Manager (SSM).
- Security groups control access between application layers.

## Important Note

The configured public IP may change. Review the ALB-SG rule if access stops working.
