
resource "azurerm_resource_group" "rg" {
  name     = "ahpterraformrg"
  location = "West Europe"
}

resource "azurerm_storage_account" "storage" {
  name                     = "ahpterraformstorage"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  name                  = "ahpterrafromcontainer"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_key_vault" "keyvault" {
  name                        = "ahpterraformkeyvault"
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
}

# resource "azurerm_databricks_workspace" "dbworkspace" {
#   name                = "ahpterraformdbworkspace"
#   resource_group_name = azurerm_resource_group.rg.name
#   location            = azurerm_resource_group.rg.location
#   sku                 = "standard"

#   tags = {
#     Environment = "DEV"
#   }
# }

# resource "databricks_group" "adb_group" {
#   provider                   = databricks
#   display_name               = "Data Engineers"
#   allow_cluster_create       = true
#   allow_instance_pool_create = true
#   depends_on = [azurerm_databricks_workspace.dbworkspace]
# }


# resource "databricks_secret_scope" "secretscope" {
#   name = "application-secret-scope"
#   initial_manage_principal = "users"
#   depends_on = [azurerm_databricks_workspace.dbworkspace]
# }
# jn