![momenton](https://s3-ap-southeast-2.amazonaws.com/aws-ecs-setup/momenton_logo.PNG)

# DevOps Challenge:

## Infrastructure problem:

You need to create one environment on AWS using ECS (ec2 launch type)
and deploy KONG API Gateway (community edition) onto it and expose the
service and management ports to the internet.
Optional: Configure a demo application to run on the same cluster and
expose the service via Kong.


## Tools used:

Terraform v0.11.11
+ provider.aws v1.59.0

Client: Docker Engine - Community
 Version:           18.09.2
 API version:       1.39
 Go version:        go1.10.8
 Git commit:        6247962
 Built:             Sun Feb 10 04:12:31 2019
 OS/Arch:           windows/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          18.09.2
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.6
  Git commit:       6247962
  Built:            Sun Feb 10 04:13:06 2019
  OS/Arch:          linux/amd64
  Experimental:     false

AWS ECS, EC2, ECR

### VPC Setup:

vpc.tf

- Creates the internet Gateway
- Creates the public subnet
- Creates the routing table
- Associates routing table to subnet
- Creates VPC security group
