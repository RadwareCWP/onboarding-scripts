
# AWS Cloud onboarding

## Template deployment

To deploy this template using CloudFormation you will firstly need to login to your aws account, 
and then use one of the following methods to deploy the Cloud Formation Template.

- [click on this link](https://console.aws.amazon.com/cloudformation/home#/stacks/create/review?templateURL=https://github.com/RadwareCloudNativeProtector/onboarding-scripts/tree/master/AWS%20onboarding%20scripts/cloudformation/radware-cft-onboarding.yaml&stackName=RadwareCNPOnboarding)
- from AWS Console select the CloudFormation service and upload the template from file to deploy it

### provide the following parameters to the CloudFormation template:
- ExternalID - The external ID provided in the CNP portal (External ID)
- RadwareAWSAccountID - The AWS account ID provided in the CNP portal (Radware AWS account ID, must be valid or will throw an error)