variable "name" {
  type        = string
  description = "Name of the Key Vault."
}

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

variable "sku_name" {
  type        = string
  description = "SKU tier of the Key Vault."
  default     = "standard"
}

variable "enable_rbac_authorization" {
  type        = bool
  description = "Flag indicating whether RBAC authorization is enabled."
  default     = true
}
