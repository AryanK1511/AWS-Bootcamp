# Terraform Course Notes

## What is Terraform?

Terraform is an **Infrastructure as Code (IaC)** tool used to provision and manage infrastructure across cloud providers like AWS, Azure, Google Cloud, and on-premises environments. It allows you to define resources using a declarative configuration language called **HCL (HashiCorp Configuration Language)**.

Declarative means that we are not giving it a set of instructions to carry out like a programming language, we are just giving it what the final stage should look like. It is like a blueprint.

## Key Features of Terraform

- **Declarative**: You define _what_ you want, and Terraform figures out _how_ to achieve it.
- **Provider Agnostic**: Works with multiple cloud providers and services.
- **Execution Plans**: Generates an execution plan before making changes.
- **State Management**: Keeps track of infrastructure in a state file.
- **Modules**: Reusable components for infrastructure code.

## Basic Terraform Commands

### Initialization

```bash
terraform init
```

- Initializes a Terraform working directory.
- Downloads the necessary provider plugins.

### Plan

```bash
terraform plan
```

- Previews the changes Terraform will make without actually applying them.

### Apply

```bash
terraform apply
```

- Applies the changes required to reach the desired state defined in the configuration files.

### Destroy

```bash
terraform destroy
```

- Destroys all resources defined in the configuration.

### Validate

```bash
terraform validate
```

- Validates the syntax and configuration of your Terraform files.

### Format

```bash
terraform fmt
```

- Formats your Terraform configuration files to a canonical style.

### Show

```bash
terraform show
```

- Displays the state or plan in a human-readable format.

### State

```bash
terraform state list
terraform state show <resource>
```

- View, modify, or manage the Terraform state.

## Terraform Configuration File Basics

### File Naming

- `main.tf`: The main configuration file.
- `variables.tf`: Defines input variables.
- `outputs.tf`: Defines output values.
- `terraform.tfvars`: Stores default variable values.
- `provider.tf`: Configures the cloud provider.

### HCL Structure

1. **Provider**: Specifies the cloud provider.

   ```hcl
   provider "aws" {
     region = "us-east-1"
   }
   ```

2. **Resources**: Defines infrastructure resources.

   ```hcl
   resource "aws_instance" "example" {
     ami           = "ami-0c55b159cbfafe1f0"
     instance_type = "t2.micro"
   }
   ```

3. **Variables**: Defines inputs for dynamic configurations.

   ```hcl
   variable "instance_type" {
     default = "t2.micro"
   }
   ```

4. **Outputs**: Specifies values to display after applying.

   ```hcl
   output "instance_id" {
     value = aws_instance.example.id
   }
   ```

## Terraform Workflow

1. **Write Configuration**: Define your infrastructure in `.tf` files.
2. **Initialize**: Run `terraform init` to download providers and initialize the workspace.
3. **Plan**: Run `terraform plan` to preview changes.
4. **Apply**: Run `terraform apply` to create/update resources.
5. **Destroy**: Use `terraform destroy` to tear down resources.

## Best Practices for Project Structure

```plaintext
project/
├── modules/
│   ├── network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── compute/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
└── provider.tf
```

- **Use Modules**: Break down infrastructure into reusable modules (e.g., network, compute).
- **Separate Files by Purpose**: Use `main.tf`, `variables.tf`, and `outputs.tf` to keep files organized.
- **State Management**: Store the state file (`terraform.tfstate`) in a remote backend for better collaboration (e.g., AWS S3, Terraform Cloud).
- **Version Control**: Use Git to track changes in `.tf` files and `.tfstate` (but never commit `.tfstate` directly).

## State Management

### What is the State?

- Terraform stores information about your infrastructure in a `.tfstate` file.
- It ensures the infrastructure matches the configuration.

### Best Practices for State

1. **Remote Backend**: Use remote backends like AWS S3 or Terraform Cloud.

   ```hcl
   terraform {
     backend "s3" {
       bucket         = "my-terraform-state"
       key            = "state/terraform.tfstate"
       region         = "us-east-1"
     }
   }
   ```

2. **Locking**: Enable state locking to avoid conflicts.
3. **Encryption**: Encrypt state files if sensitive data is stored.

## Variables and Outputs

### Variables

Variables allow dynamic configuration.

1. **Define**:

   ```hcl
   variable "instance_type" {
     description = "Type of EC2 instance"
     default     = "t2.micro"
   }
   ```

2. **Use**:

   ```hcl
   resource "aws_instance" "example" {
     instance_type = var.instance_type
   }
   ```

3. **Override**:

   - In `terraform.tfvars`:

     ```hcl
     instance_type = "t2.large"
     ```

   - Using CLI:

     ```bash
     terraform apply -var="instance_type=t2.large"
     ```

### Outputs

Outputs display useful information after a resource is created.

```hcl
output "instance_ip" {
  value = aws_instance.example.public_ip
}
```

## Terraform Modules

### What are Modules?

- Reusable components to simplify infrastructure management.
- Example structure:

  ```plaintext
  modules/
  ├── network/
  │   ├── main.tf
  │   ├── variables.tf
  │   └── outputs.tf
  ```

- Use a module:

  ```hcl
  module "network" {
    source = "./modules/network"
    vpc_id = var.vpc_id
  }
  ```

## Backends

Backends determine where Terraform stores its state.

1. **Local**: Default; stores state in the current directory.
2. **Remote**: Store state in services like S3, Terraform Cloud, etc.

   ```hcl
   terraform {
     backend "s3" {
       bucket = "my-terraform-state"
       key    = "state/terraform.tfstate"
       region = "us-east-1"
     }
   }
   ```

## Common Use Cases

1. **Provisioning EC2 Instances**

   ```hcl
   resource "aws_instance" "example" {
     ami           = "ami-0c55b159cbfafe1f0"
     instance_type = "t2.micro"
   }
   ```

2. **Creating an S3 Bucket**

   ```hcl
   resource "aws_s3_bucket" "example" {
     bucket = "my-example-bucket"
   }
   ```

3. **Configuring Networking**

   ```hcl
   resource "aws_vpc" "example" {
     cidr_block = "10.0.0.0/16"
   }
   ```

## Troubleshooting

1. **Check Logs**: Use `TF_LOG` for detailed debugging.

   ```bash
   export TF_LOG=DEBUG
   terraform apply
   ```

2. **State Conflicts**: Resolve conflicts by locking the state file in the backend or running `terraform state` commands.

3. **Validate Configurations**: Run `terraform validate` to check for syntax errors.
