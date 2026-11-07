# ShopSphere - AWS Cost Estimate

## 1. Estimation Assumptions

- AWS Region: Asia Pacific (Mumbai) - ap-south-1
- Estimation period: 730 hours (approximately 1 month)
- Currency: USD
- EC2 instance: 1 x t3.micro, Amazon Linux
- EBS volume: 8 GB gp3, encrypted
- Network: 1 NAT Gateway
- Public IPv4 assumption: 2 addresses (EC2 and NAT Gateway)
- NAT data processing assumption: 1 GB
- Taxes and applicable data transfer charges are excluded.

## 2. Illustrative Monthly Cost

| Component | Assumption | Estimated Cost |
|---|---|---:|
| EC2 t3.micro | $0.0112 x 730 hours | $8.18 |
| Public IPv4 | 2 x $0.005 x 730 hours | $7.30 |
| NAT Gateway | $0.056 x 730 hours | $40.88 |
| NAT data processing | 1 GB x $0.056 | $0.06 |
| EBS gp3 | 8 GB | Verify in AWS Pricing Calculator |
| S3 | Small artifact storage and requests | Usage based |

Illustrative subtotal for the priced items above: approximately $56.42 per month.

This subtotal excludes EBS, S3, taxes, data transfer, and any other project services. It is not the complete project bill.

## 3. EC2 Pricing Models Comparison

| Pricing Model | Description | Suitability |
|---|---|---|
| On-Demand | Pay for usage without long-term commitment | Best for this short project |
| Spot Instances | Uses spare AWS capacity at discounted prices; instances can be interrupted | Suitable for interruptible workloads |
| Reserved Instances | Commitment for 1 or 3 years for discounted pricing | Not suitable for a short project |
| Savings Plans | Commitment to a consistent usage amount for 1 or 3 years | Not suitable for a short project |
| Dedicated Hosts | Physical server dedicated to one customer | Not required for this lab |

Selected model: On-Demand, because the project is temporary and does not require a long-term commitment.

## 4. Cost Optimization

- Stop or terminate EC2 when it is no longer required.
- Delete the NAT Gateway after project completion.
- Release unused Elastic IP addresses.
- Delete unused EBS volumes and snapshots.
- Keep S3 buckets private and remove unnecessary test artifacts.
- Review AWS Cost Explorer and Billing regularly.

## 5. Pricing References

- AWS EC2 Pricing: https://aws.amazon.com/ec2/pricing/on-demand/
- AWS VPC Pricing: https://aws.amazon.com/vpc/pricing/
- AWS Pricing Calculator: https://calculator.aws/

Reference rates are illustrative estimates checked in November 2026. Verify regional prices in AWS Pricing Calculator before making spending decisions.
