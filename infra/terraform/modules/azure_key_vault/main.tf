terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

resource "azurerm_key_vault" "kv" {
  name                      = var.name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  tenant_id                 = var.tenant_id
  sku_name                  = var.sku_name
  enable_rbac_authorization = var.enable_rbac_authorization
}
