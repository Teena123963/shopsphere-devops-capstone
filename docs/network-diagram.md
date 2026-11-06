
# ShopSphere AWS VPC Network Diagram

## VPC Details
- Region: ap-south-1
- VPC ID: vpc-0b6ded536f74e843c
- VPC CIDR: 10.20.0.0/16

## Subnets

| Subnet | CIDR | Availability Zone |
|---|---|---|
| Public A | 10.20.1.0/24 | ap-south-1a |
| Public B | 10.20.2.0/24 | ap-south-1b |
| App A | 10.20.11.0/24 | ap-south-1a |
| App B | 10.20.12.0/24 | ap-south-1b |
| DB A | 10.20.21.0/24 | ap-south-1a |
| DB B | 10.20.22.0/24 | ap-south-1b |

## Network Routing
- Public Route Table: Default route to Internet Gateway.
- App Route Table: Default route to NAT Gateway.
- DB Route Table: Local VPC route only; no direct internet route.
- NAT Gateway: Located in Public Subnet A.
- Internet Gateway: Attached to the VPC.

## Security Groups
- ALB-SG: TCP 80 from the configured public IP.
- APP-SG: TCP 5000 from ALB-SG only.
- DB-SG: TCP 5432 from APP-SG only.
- ADMIN-SG: No inbound rules; administration planned through SSM.

## Network ACL
- Default NACL is associated with all six subnets.
- Custom NACL was created but is not associated with any subnet.

## Important Note
DB subnets do not have a direct Internet Gateway or NAT Gateway route.
