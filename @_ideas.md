# Ideas for my home lab

Setup Proxmox on the Thinkpad; good for snapshots & cross platform operations. We will have Proxmox on bare metal, a couple of Ubuntu VMs

Have a Web GUI (uploadtigris.com) with applications that using Route53, route me to different self-hosted services like pi-hole, plex, next-cloud, etc
- can log in as user
- can save custom themes for login page

------------------------------------------------------------

Desktop as a production server
- 16 GB Ram
- Radeon 580 GPU
- 2, 2 TB Drives for storage (mirrored)
- OS: ProxMox (VM1: Ubuntu Server running Grafana, VM2: Alma Linux)

Laptop as a Test Environment
- Thinkpad W541
- 32 GB RAM
- OS: ProxMox

------------------------------------------------------------

!Begin to make documents for the setup and automation of each servce

[X] Pi-Hole \
[ ] Pfsense \
[ ] DDNS \
[ ] Next Cloud \
[ ] Ngnix web hosting\

------------------------------------------------------------
AWS
Build Manual First > IaC using Terraform
[ ] Three tier web application (web server - EC2, application - EC2/Lambda, database tier - RDS) with application load balancer
[ ] Make it highly available ( multiple AZs, auto scaling groups, RDS Multi-AZ, Route 53 for DNS failover.
[ ] Serverless ( build something with API Gateway, Lambda, and DynamoDB ) + S3 static hosting // CloudFront for distribution
[ ] Hybrid cloud connections ~ set up a VPN connection b/w homelab and the VPC. ( VPC peering, Transit Gateway, Direct Connect concepts )
[ ] Security and compliance ~ IAM roles and policies, CloudTrail, KMS Encryption, AWS config rules, AWS Systems Manager
[ ] Cost Optimization ~ Cost Explorer, billing alarms, S3 lifecycle policies, EC2 instance sizing, Reserved instances and savings plans (go hard in this, use that economics brain)
[ ] IaC - Build things in CloudFormation && Terraform

