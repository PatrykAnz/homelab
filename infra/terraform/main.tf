resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "keyvault" {
  source              = "./modules/azure_key_vault"
  name                = var.key_vault_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = var.tenant_id
}
