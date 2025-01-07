terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.14.0"
    }
    databricks = {
      source = "databricks/databricks"
    }
  }

  backend "azurerm" {
  }
}

provider "azurerm" {
  features {}
}

# provider "databricks" {
#   host                = azurerm_databricks_workspace.dbworkspace.workspace_url
#   azure_client_id     = data.azurerm_key_vault_secret.apdap-devops-sc-client-id.value
#   azure_client_secret = data.azurerm_key_vault_secret.apdap-devops-sc-client-secret.value
#   azure_tenant_id     = var.tenant_id
# }