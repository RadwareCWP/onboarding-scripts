terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">=4.21.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

variable "role_name" {
  type        = string
  description = "The name of CNP onboarding role for your account"
  default = "Radware_CNP_TF"
  nullable = false
}

variable "radware_aws_account_id" {
  type        = string
  description = "The AWS account ID provided in the CNP portal (Radware AWS account ID, must be valid or will throw an error)"
  nullable = false
}

variable "external_id" {
  type        = string
  description = "The external ID provided in the CNP portal (External ID)"
  nullable = false
}

data "aws_iam_policy" "required-policy-SecurityAudit" {
  arn = "arn:aws:iam::aws:policy/SecurityAudit"
}

data "aws_iam_policy" "required-policy-AWSWAFReadOnlyAccess" {
  arn = "arn:aws:iam::aws:policy/AWSWAFReadOnlyAccess"
}

data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = ["arn:aws:iam::${var.radware_aws_account_id}:root/"]
    }
    condition {
      test = "StringEquals"
      variable = "sts:ExternalId"
      values = ["${var.external_id}"]
    }
  }
}

resource "aws_iam_role" "radware_cnp_role" {
  name = var.role_name
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "attach-SecurityAudit-policy" {
  role       = aws_iam_role.radware_cnp_role.name
  policy_arn = data.aws_iam_policy.required-policy-SecurityAudit.arn
}

resource "aws_iam_role_policy_attachment" "attach-AWSWAFReadOnlyAccess-policy" {
  role       = aws_iam_role.radware_cnp_role.name
  policy_arn = data.aws_iam_policy.required-policy-AWSWAFReadOnlyAccess.arn
}

output "Role_ARN_for_CNP_Portal" {
  description = "Role ARN for CNP Portal"
  value = aws_iam_role.radware_cnp_role.arn
}