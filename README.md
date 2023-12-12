Description: Terraform module to create a VPC's with private subnets, SSM session manager and ec2 for each region.
* EC2 can be accessed via SSM session manager.
* EC2 can ping each other via private IP.

<br>
<h3> Let's get started </h3>
Clone the repository
<br>
Edit provider.tf file and adjust region

Add credentials to github actions secrets/variables:
<br>
secrets:
* AWS_ACCESS_KEY_ID
* AWS_SECRET_ACCESS_KEY
* TFSTATE_BUCKET
  
variables:
* TFSTATE_KEY
* TFSTATE_REGION


Export variables for terraform s3 backend (need to create s3 bucket for terraform state)

```
export TFSTATE_BUCKET="terraform-state-example"
export TFSTATE_KEY="terraform.tfstate"
export TFSTATE_REGION="eu-west-1"
```

Run terraform init with backend configuration
```
terraform init \
-backend-config="bucket=${TFSTATE_BUCKET}" \
-backend-config="key=${TFSTATE_KEY}" \
-backend-config="region=${TFSTATE_REGION}" 
```

Run terraform plan
```
terraform plan
```

Run terraform apply
```
terraform apply
```

Potential improvements:  
* Set private kms key for ssm     
* store log output for all sessions in s3 bucket
* VPC Network Firewall associated
* pre commit hooks (tflint, terraform fmt, terraform validate, terraform docs, security checks, etc)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.30.0 |
| <a name="provider_aws.peer"></a> [aws.peer](#provider\_aws.peer) | 5.30.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_region-1"></a> [region-1](#module\_region-1) | ./ssm-private-ec2 | n/a |
| <a name="module_region-2"></a> [region-2](#module\_region-2) | ./ssm-private-ec2 | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_route.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.peer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_vpc_peering_connection.peer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection) | resource |
| [aws_vpc_peering_connection_accepter.peer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_accepter) | resource |
| [aws_caller_identity.peer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_route_table.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_table) | data source |
| [aws_route_table.secondary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_table) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region-1"></a> [region-1](#input\_region-1) | Region 1 | `map` | <pre>{<br>  "region": "eu-west-1",<br>  "vpc_cidr": "10.0.0.0/16"<br>}</pre> | no |
| <a name="input_region-2"></a> [region-2](#input\_region-2) | Region 2 | `map` | <pre>{<br>  "region": "eu-west-2",<br>  "vpc_cidr": "10.1.0.0/16"<br>}</pre> | no |

## Outputs

No outputs.


Reference:
https://github.com/andrescueva/ssm-private-ec2