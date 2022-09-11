
# Azure Terraform onboarding

## Prerequisite 
### Terraform requirements
- Terraform >= v1.2.3
- provider registry.terraform.io/hashicorp/azuread >= v2.25.0
- provider registry.terraform.io/hashicorp/azurerm >= v3.11.0

### Azure requirements
- install az cli
- run 'az login' to login to your Azure Tenant

## Template deployment

### To deploy this template using Terraform you will firstly need to login to your Azure account:

```bash
  az login
```

afterwards you can deploy the Terraform template.
### suggested template deployment process

- clone the repository or download the 'onboarding-cnp-azure.tf' file.

``` bash
git clone https://github.com/RadwareCloudNativeProtector/onboarding-scripts.git
```

- navigate to the folder containing that file (assuming you cloned the repository, this should be the path)
``` bash
cd '.\Azure onboarding scripts\terraform\'
```

- create a terraform plan, and save the plan to apply later on

```bash
  terraform plan -out onboarding-plan 
```

### terraform will generate the following resources with the base name
- azure AD application named <Base_Name>
- custom role named <Base_Name>_role

note: the default base name for Azure resources will is 'Radware_CNP'

### terraform will take a couple of minutes to discover and plan the resource creation
- review the plan's outputs and make sure they are correlated to the Azure Account and CNP tenant

### apply the template
- now the plan has been created succsfully, all that is left is to apply the terraform plan

```bash
  terraform apply "onboarding-plan"
```

### Appendix: Override plan variables
#### to override variables you can specify them in the following manner

```
terraform plan -var="base_name=Radware_CNP_Custom" -out onboarding-plan 
```
