
# AWS Terraform onboarding

## Prerequisite 
### Terraform requirements
- Terraform >= v1.2.3
- provider registry.terraform.io/hashicorp/aws >= v4.21.0

### AWS requirements
- install aws cli
- API Key for aws cli login

## Template deployment

To deploy this template using Terraform you will firstly need to login to your aws account
using the API Key, to provide it you can run:

```bash
  aws configure
```

a prompt will request that you provide the following:
- AWS Access Key ID
- AWS Secret Access Key
- Default region name
- Default output format

afterwards you can run the Terraform template - you can use the following suggested process.

create a terraform plan, and save the plan to apply later on

```bash
  terraform plan -out onboarding-plan 
```

the terraform will request that you set the following:
- The external ID provided in the CNP portal (External ID)
- The AWS account ID provided in the CNP portal (Radware AWS account ID, must be valid or will throw an error)

the AWS IAM role that will be created will be named 'Radware_CNP_TF'.



review the plan's outputs and make sure they are correlated to the AWS Account and CNP tenant
now the plan has been created succsfully, all that is left is to apply the terraform plan

```bash
  terraform apply "onboarding-plan"
```

### Appendix: Override plan variables
#### to override variables you can specify them in the following manner

```
terraform plan -var="role_name=Radware_CNP" -var="external_id=<ID_PROVIDED_IN_CNP_PORTAL>" -var="radware_aws_account_id=<RADWARE_ACCOUNT_ID_PROVIDED_IN_CNP_PORTAL>" -out onboarding-plan 
```

#### example usage
```bash
  terraform plan -var="role_name=Radware_CNP" -var="external_id=AHhYefFr34D123D" -var="radware_aws_account_id=1234567890" -out onboarding-plan
```
