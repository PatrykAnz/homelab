variable "location" {
  type        = string
  description = "Name of the Azure region."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "tenant_id" {
  type        = string
  description = "Tenant ID of the directory in Microsoft Entra ID."
}

variable "key_vault_name" {
  type        = string
  description = "Name of the Key Vault."
}

variable "subscription_id" {
  type        = string
  description = "Name of the subscription."
}
