provider "azurerm" {
  features {}
}

# Resource Group for Bootstrap Storage
resource "azurerm_resource_group" "bootstrap_rg" {
  name     = var.bootstrap_resource_group_name
  location = var.location
}

# Storage Account for Terraform State
resource "azurerm_storage_account" "bootstrap_storage" {
  name                     = var.bootstrap_storage_account_name
  resource_group_name      = azurerm_resource_group.bootstrap_rg.name
  location                 = azurerm_resource_group.bootstrap_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  lifecycle {
    prevent_destroy = true
  }
}

# Storage Container for State Files
resource "azurerm_storage_container" "bootstrap_container" {
  name                  = var.bootstrap_container_name
  storage_account_name  = azurerm_storage_account.bootstrap_storage.name
  container_access_type = "private"
}

# Output Variables
output "resource_group_name" {
  value = azurerm_resource_group.bootstrap_rg.name
}

output "storage_account_name" {
  value = azurerm_storage_account.bootstrap_storage.name
}

output "container_name" {
  value = azurerm_storage_container.bootstrap_container.name
}
