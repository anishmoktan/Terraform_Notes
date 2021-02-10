# Learning Terraform

Terraform is the infrastructure as code tool from HashiCorp. It is a tool for building, changing, and managing infrastructure in a safe, repeatable way. Operators and Infrastructure teams can use Terraform to manage environments with a configuration language called the HashiCorp Configuration Language (HCL) for human-readable, automated deployments.

## Workflows
1. **Scope** - Confirm what resources need to be created for a given project.
2. **Author** - Create the configuration file in HCL based on the scoped parameters
3. **Initialize** - Run ```terraform init``` in the project directory with the configuration files. This will download the correct provider plug-ins for the project.
4. **Plan & Apply** - Run ```terraform plan``` to verify creation process and then ```terraform apply``` to create real resources as well as state file that compares future changes in your configuration files to what actually exists in your deployment environment.

## Advantages of Terraform 
1. **Platform Agnostic** - run equally well across more than one cloud platform with the same workflow by creating a configuration file to fit the needs of your project or organization.
2. **State Management** - Terraform creates a state file when a project is first initialized. Terraform uses this local state to create plans and make changes to your infrastructure. Prior to any operation, Terraform does a refresh to update the state with the real infrastructure. This means that Terraform state is the source of truth by which configuration changes are measured. If a change is made or a resource is appended to a configuration, Terraform compares those changes with the state file to determine what changes result in a new resource or resource modifications.
3. **Operator Confidence** - The workflow built into Terraform aims to instill confidence in users by promoting easily repeatable operations and a planning phase to allow users to ensure the actions taken by Terraform will not cause disruption in their environment. Upon ```terraform apply```, the user will be prompted to review the proposed changes and must affirm the changes or else Terraform will not apply the proposed plan.


***Sources:*** 

https://learn.hashicorp.com/collections/terraform/aws-get-started
https://learn.hashicorp.com/tutorials/terraform/infrastructure-as-code?in=terraform/aws-get-started


## Quick Terraform Guide
1. Run Docker
2. Paste the following Terraform configuration into a file and name it ```main.tf```
```hcl    
terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "tutorial"
  ports {
    internal = 80
    external = 8000
  }
}
```
3. Initialize the project, which downloads a plugin that allows Terraform to interact with Docker.
> ```terraform init```
4. Provision the NGINX server container with ```apply```. When Terraform asks you to confirm type ```yes``` and press ```ENTER```.
> ```terraform apply```
5. Verify the existence of the NGINX container by visiting localhost:8000 in your web browser or running ```docker ps``` to see the container.
```
$ docker ps
CONTAINER ID        IMAGE                     COMMAND                  CREATED             STATUS              PORTS                    NAMES
425d5ee58619        e791337790a6              "nginx -g 'daemon of…"   20 seconds ago      Up 19 seconds       0.0.0.0:8000->80/tcp     tutorial
```
6. To stop the container, run ```terraform destroy```.
