# Deploy a High-Availability Web App using CloudFormation 
> Part of Udacity's DevOps ND: Creating this project will give you the hands-on experience you need to confidently talk about infrastructure as code. We have chosen a realistic scenario where you will deploy a dummy application (a sample JavaScript or HTML file) to the Apache Web Server running on an EC2 instance.


---
## **Overview:**
Your company is creating an Instagram clone called Udagram.

Developers want to deploy a new application to the AWS infrastructure.

You have been tasked with provisioning the required infrastructure and deploying a dummy application, along with the necessary supporting software.

This needs to be automated so that the infrastructure can be discarded as soon as the testing team finishes their tests and gathers their results.

## **Architecture Diagram:**

<br>
<p align="center">
<img src="imgs\Udacity DevOps - 2nd Project - Architecture Diagram.png" title="Architecture Diagram" alt="Architecture Diagram" width=100%><br>
<b>Architecture Diagram</b>
</p>


> [View on Lucidchart](https://lucid.app/lucidchart/acd8d394-692c-4714-a652-9c3f8fa376fc/edit?viewport_loc=-198%2C2670%2C2368%2C1216%2C0_0&invitationId=inv_a0855ecf-8bba-45d7-943d-1a6b44a31b6b)


## **Specifications:**

> - You'll need to create a Launch Configuration for your application servers in order to deploy four servers, two located in each of your private subnets. The launch configuration will be used by an auto-scaling group.
> - You'll need two vCPUs and at least 4GB of RAM. The Operating System to be used is Ubuntu 18. So, choose an Instance size and Machine Image (AMI) that best fits this spec.
> - Be sure to allocate at least 10GB of disk space so that you don't run into issues. 
Security Groups and Roles


- Since you will be downloading the application archive from an S3 Bucket, you'll need to create an IAM Role that allows your instances to use the S3 Service.
Udagram communicates on the default HTTP Port: 80, so your servers will need this inbound port open since you will use it with the Load Balancer and the Load Balancer Health Check. As for outbound, the servers will need unrestricted internet access to be able to download and update their software.
- The load balancer should allow all public traffic (0.0.0.0/0) on port 80 inbound, which is the default HTTP port. Outbound, it will only be using port 80 to reach the internal servers.
-The application needs to be deployed into private subnets with a Load Balancer located in a public subnet.
One of the output exports of the CloudFormation script should be the public URL of the LoadBalancer. Bonus points if you add http:// in front of the load balancer DNS Name in the output, for convenience.

## **Usage:**
- Clone the repository:
    ```sh
    $ git clone https://github.com/kfrawee/deploy-web-app-cloudformation.git
    ```

- Navigate to the directory:
    ```sh
    $ cd .\deploy-web-app-cloudformation\
    ```
> This project uses [`AWS CLI`](https://aws.amazon.com/cli/). So, make sure you get that first and give the necessary permissions to `aws cli`. Follow [this page](https://aws.amazon.com/documentation/cli/) for getting started. <br>

1. Store stack names variables: 
```sh
$ export networks_stack_name="networks"
$ export servers_stack_name="servers"
```
2. Create networks stack:
```sh
$ sh create.sh $networks_stack_name templates/udacity_project_networks.yml templates/udacity_project_nerworks_params.json
Creating stack: networks
{
    "StackId": "arn:aws:cloudformation:us-east-1:452206074273:stack/networks/6e659830-8d2d-11ed-8f30-0e0c198b19b3"
}
```
3. Create servers stack:
```sh
$ sh create.sh $servers_stack_name templates/udacity_project_servers.yml templates/udacity_project_servers_params.json
Creating stack: servers
{
    "StackId": "arn:aws:cloudformation:us-east-1:452206074273:stack/servers/2d5623c0-8d30-11ed-a8e2-0eaa196a18d1"
}
```

## **Cleaning:**
```sh
$ sh delete.sh $servers_stack_name 
Deleting stack: servers
$ sh delete.sh $networks_stack_name 
Deleting stack: networks
```