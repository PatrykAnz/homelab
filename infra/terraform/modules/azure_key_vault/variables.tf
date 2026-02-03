variable "name" {
  type        = string
  description = "Key Vault name."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name."
}

variable "location" {
  type        = string
  description = "Azure region."
}

variable "tenant_id" {
  type        = string
  description = "Entra ID tenant."
}

variable "sku_name" {
  type        = string
  description = "Standard or premium."
  default     = "standard"

  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "Must be standard or premium."
  }
}

variable "enable_rbac_authorization" {
  type        = bool
  description = "Enable RBAC mode."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Resource tags."
  default     = {}
}
