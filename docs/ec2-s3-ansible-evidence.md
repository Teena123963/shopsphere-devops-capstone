# ShopSphere EC2, S3 and Ansible Evidence

## 1. EC2 Configuration

- Region: ap-south-1 (Mumbai)
- Instance ID: i-0bda8dffadeb5edba
- Instance type: t3.micro
- Operating system: Amazon Linux 2023
- Private IP: 10.20.1.224
- IAM role: ShopSphereEC2Role
- Instance profile: ShopSphereEC2Role
- Root volume: 8 GB gp3, encrypted
- Access method: AWS Systems Manager (Session Manager)
- Security: No SSH inbound rule open to the internet.

## 2. S3 Bucket Configuration

### Main artifact bucket

- Bucket: shopsphere-artifacts-058416978799-ap-south-1
- Region: ap-south-1
- Versioning: Enabled
- Block Public Access: All four settings enabled
- Uploaded object: shopsphere-artifact.txt

### Ansible transfer bucket

- Bucket: shopsphere-ansible-transfer-058416978799-ap-south-1
- Region: ap-south-1
- Block Public Access: All four settings enabled
- Used by Ansible AWS SSM connection plugin for file transfer.

## 3. Ansible Configuration

Ansible control environment is built using Docker.

Files:
- infra/ansible/Dockerfile
- infra/ansible/inventory.ini
- infra/ansible/site.yml

Ansible version: ansible-core 2.21.6
AWS collection: amazon.aws

The inventory connects to the EC2 instance using the AWS SSM connection plugin.

The playbook:
- Ensures NGINX is installed.
- Ensures NGINX is running and enabled.
- Deploys the ShopSphere homepage.
- Checks the homepage using an HTTP request.

## 4. Verification Results

Ansible connectivity test:
- Result: SUCCESS
- Ping: pong

Ansible playbook:
- Tasks OK: 5
- Changed: 0
- Unreachable: 0
- Failed: 0

HTTP verification:
- URL: http://localhost
- Expected status: 200
- Actual status: 200

Homepage content:
Welcome to ShopSphere

## 5. Access and Security Notes

- EC2 access is through Systems Manager Session Manager.
- No SSH key is stored in the Git repository.
- AWS credentials remain outside the project repository.
- S3 public access is blocked on both buckets.
