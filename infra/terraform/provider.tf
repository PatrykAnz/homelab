provider "azurerm" {
  features {}
  # Shared key access is disabled on the state storage account.
  storage_use_azuread = true
  subscription_id     = var.subscription_id
  tenant_id           = var.tenant_id
}

provider "azuread" {
  tenant_id = var.tenant_id
}
