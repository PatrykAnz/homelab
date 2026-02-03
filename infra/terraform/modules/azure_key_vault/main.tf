resource "azurerm_key_vault" "key_vault" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tenant_id           = var.tenant_id

  sku_name                   = var.sku_name
  rbac_authorization_enabled = var.enable_rbac_authorization

  tags = var.tags
}
