# Summary: A simple Azure Active Directory Application

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=2.25.0"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">=3.11.0"
    }
  }
}

variable "base_name" {
  type        = string
  description = "The name to use for application creation"
  default = "Radware_CNP"
}

provider "azurerm" {
   features {}
}

data "azurerm_subscription" "current" {
}

data "azuread_client_config" "current" {
}

# Create an Azure AD Application for CNP's permissions and access config
resource "azuread_application" "Radware_CNP" {
  display_name = var.base_name
  
  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

    resource_access {
      id   = "7ab1d382-f21e-4acd-a863-ba3e13f7da61" # Directory.Read.All
      type = "Role"
    }
  }
}

# attach the Azure AD Application to a service principal
resource "azuread_service_principal" "Radware_CNP_sp" {
  application_id               = azuread_application.Radware_CNP.application_id
  app_role_assignment_required = true
  owners                       = [data.azuread_client_config.current.object_id]
}

# create a Secret under our new application
resource "azuread_application_password" "Radware_CNP_secret" {
  application_object_id = azuread_application.Radware_CNP.object_id
}

# defining a custom role with the permissions required for CNP
resource "azurerm_role_definition" "Radware_CNP_role" {
  name        = format("%s%s", var.base_name, "_role")
  scope       = data.azurerm_subscription.current.id
  description = "This is a custom role created via Terraform for CNP"

  permissions {
    actions     = ["Microsoft.Network/networkWatchers/queryFlowLogStatus/action"] ## Microsoft.Network/networkWatchers/queryFlowLogStatus/action
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.current.id, # /subscriptions/00000000-0000-0000-0000-000000000000
  ]
}

# assiging the custom role to the application created for CNP
resource "azurerm_role_assignment" "CNP_role_to_app" {
  scope                             = data.azurerm_subscription.current.id
  role_definition_id                = azurerm_role_definition.Radware_CNP_role.role_definition_resource_id
  principal_id                      = azuread_service_principal.Radware_CNP_sp.id
}

# assiging the Reader role to the application created for CNP
resource "azurerm_role_assignment" "Reader_role_to_app" {
  role_definition_name              = "Reader"
  scope                             = data.azurerm_subscription.current.id
  principal_id                      = azuread_service_principal.Radware_CNP_sp.id
}

# outputs of all CNP's onboarding required info
output "Tenant_ID" {
  description = "Tenant ID"
  value = data.azurerm_subscription.current.tenant_id
}

output "Subscription_ID" {
  description = "Subscription ID"
  value = data.azurerm_subscription.current.id
}

output "Application_ID" {
  description = "Application ID"
  value = azuread_application.Radware_CNP.application_id
}

output "Application_Key" {
  description = "Application Key"
  value = nonsensitive(azuread_application_password.Radware_CNP_secret.value)
}

output "Message_about_consent" {
  value = "Please make sure app API permissions have admin consent."
}