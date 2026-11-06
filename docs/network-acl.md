# ShopSphere – Network ACL Configuration

## 1. Overview

A custom Network ACL (NACL) was created for the ShopSphere VPC.

- **VPC ID:** `vpc-0b6ded536f74e843c`
- **Custom NACL ID:** `acl-04c26fdda871a04b5`
- **Region:** `ap-south-1`
- **NACL Type:** Custom
- **Default NACL:** `False`
- **Subnet Association:** None

## 2. Inbound Rules

| Rule Number | Protocol | Port Range | Source | Action |
|---|---|---|---|---|
| 100 | TCP | 80 | 0.0.0.0/0 | Allow |
| 110 | TCP | 1024–65535 | 0.0.0.0/0 | Allow |
| 120 | TCP | 443 | 0.0.0.0/0 | Allow |
| 32767 | All | All | 0.0.0.0/0 | Deny |

## 3. Outbound Rules

| Rule Number | Protocol | Port Range | Destination | Action |
|---|---|---|---|---|
| 100 | TCP | 80 | 0.0.0.0/0 | Allow |
| 110 | TCP | 1024–65535 | 0.0.0.0/0 | Allow |
| 120 | TCP | 443 | 0.0.0.0/0 | Allow |
| 32767 | All | All | 0.0.0.0/0 | Deny |

## 4. Important Concepts

- Network ACLs are stateless.
- Inbound and outbound rules are configured separately.
- Rule numbers determine the order in which rules are evaluated.
- The default rule 32767 denies traffic that does not match an earlier rule.
- Ephemeral ports are included for return traffic.

## 5. Verification

The custom NACL rules were verified using AWS CLI:

```powershell
aws ec2 describe-network-acls --network-acl-ids acl-04c26fdda871a04b5 --region ap-south-1 --no-cli-pager --output table
```

All configured inbound and outbound rules were visible in the verification output.

## 6. Association Status and Limitations

The custom NACL is currently not associated with any subnet.

The existing default NACL remains associated with the project subnets.

These rules are a basic learning configuration, not a complete production-ready NACL. Application-to-database and other internal subnet traffic rules have not been configured here.

The custom NACL will not affect current project traffic while it remains unassociated.