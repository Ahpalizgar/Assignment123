data "azurerm_key_vault_secret" "apdap-devops-sc-client-id" {
  name         = "apdap-devops-sc-client-id"
  key_vault_id = var.key_vault_id
}

data "azurerm_key_vault_secret" "apdap-devops-sc-client-secret" {
  name         = "apdap-devops-sc-client-secret"
  key_vault_id = var.key_vault_id
}

