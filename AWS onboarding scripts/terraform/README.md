
# AWS Terraform onboarding

## Prerequisite 
### Terraform requirements
- Terraform >= v1.2.3
- provider registry.terraform.io/hashicorp/aws >= v4.21.0

### AWS requirements
- install aws cli
- API Key for aws cli login

## Template deployment
### login to your aws account using the API Key:

```bash
  aws configure
```

- a prompt will request that you provide the following:
  - AWS Access Key ID
  - AWS Secret Access Key
  - Default region name
  - Default output format

afterwards you can deploy the Terraform template.
### suggested template deployment process

- clone the repository or download the 'onboarding-cnp-aws.tf' file.

``` bash
git clone https://github.com/RadwareCloudNativeProtector/onboarding-scripts.git
```

- navigate to the folder containing that file (assuming you cloned the repository, this should be the path)
``` bash
cd '.\onboarding-scripts\AWS onboarding scripts\terraform\'
```

- create a terraform plan, and save the plan to apply later on

```bash
  terraform plan -out onboarding-plan 
```

### terraform will require that you set the following variable in the cli prompt:
- The external ID provided in the CNP portal (External ID)
- The AWS account ID provided in the CNP portal (Radware AWS account ID, must be valid or will throw an error)

note: the AWS IAM role default value 'Radware_CNP_TF', which can be overriden

### terraform will take a couple of minutes to discover and plan the resource creation
- review the plan's outputs and make sure they are correlated to the AWS Account and CNP tenant

### apply the template
- now the plan has been created succsfully, all that is left is to apply the terraform plan

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
  terraform plan -var="role_name=Radware_CNP" -var="external_id=AHhYefFr34D123D" -var="radware_aws_account_id=123456789012" -out onboarding-plan
```
