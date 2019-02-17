# DevOps Challenge:

![momenton](https://s3-ap-southeast-2.amazonaws.com/aws-ecs-setup/momenton_logo.PNG)

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

* All variables defined in a variables.tf file which is not available in this repo for obvious reasons.

### Setup IAM Roles:

IAM Roles are required for the agent and service scheduler. They will be passed to the instances after they have launched.

### App load balancer required to setup

To setup the load balancer you will need to create a minimum of two subnets across two different availability zones.

### Auto scaling group and launch configuration:

A launch config is like a template that the asg will use to create your instances.

### ECS Cluster:

Create the ecs cluster using variables specified in your env variables file.

### Task definition:

Create your task definition script which will define the containers used in the cluster.

### Docker Images:

I used docker and ECR for my kong image. In order to auth with AWS from docker cli, you will first need to install AWS CLI for windows in my case. The run the following :

```
Authenticate docker with AWS using the AWS CLI:

aws ecr get-login --region us-west-1 --no-include-email
```

The returned URI can be used to push your image to ECR repo.
