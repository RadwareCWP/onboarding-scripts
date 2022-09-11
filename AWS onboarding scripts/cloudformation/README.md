
# AWS CloudFormation onboarding

## Template deployment

To deploy this template using CloudFormation you will firstly need to login to your aws account, 
and then use one of the following methods to deploy the Cloud Formation Template.

###  clone the repository to your workstation or download the cft template file
``` bash
git clone https://github.com/RadwareCloudNativeProtector/onboarding-scripts.git
```

### AWS Console

- navigate to the CloudFormation service in AWS Console
- select 'Create Stack' -> Template is ready -> Upload a template file
- find the 'cnp-cft-onboarding.yaml' file and choose it, you may click 'View in Designer' to review the template
- specify the ExternalID, RadwareAWSAccountID that is provided in the CNP portal
- optionally: specify the RoleName or leave the default value 'RadwareCNP_Access'
- click on Next -> Next -> check the 'I acknowledge that AWS CloudFormation might create IAM resources with custom names.' Checkbox
- click on 'Create Stack' to deploy the CloudFormation template

### AWS CLI
- login to aws cli by running 
``` bash
  aws configure
```
a prompt will request that you provide the following:
- AWS Access Key ID
- AWS Secret Access Key
- Default region name
- Default output format
  
- navigate to the CFT folder (assuming you cloned the repository, this should be the path)
``` bash
  cd '.\onboarding-scripts\AWS onboarding scripts\cloudformation\'
```
-  run the following command to deploy the 
``` bash
  aws cloudformation deploy --capabilities 
  CAPABILITY_NAMED_IAM --template-file .\cnp-cft-onboarding.yaml --stack-name CNPRoleCreate --parameter-overrides ExternalID=<CNP_EXTERNAL_ID> RadwareAWSAccountID=<AWS_ACCOUNT_ID>
```

#### example usage
```bash
  aws cloudformation deploy --capabilities 
  CAPABILITY_NAMED_IAM --template-file .\cnp-cft-onboarding.yaml --stack-name CNPRoleCreate1 --parameter-overrides ExternalID=ABCDEFGHIJKLMNOP123 RadwareAWSAccountID=123456789012
```

### CloudFormation template accepts the following parameters:
- ExternalID - The external ID provided in the CNP portal (External ID)
- RadwareAWSAccountID - The AWS account ID provided in the CNP portal (Radware AWS account ID, must be valid or will throw an error)

