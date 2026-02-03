variable "environment" {
  type        = string
  description = "Environment name."
}

variable "location" {
  type        = string
  description = "Azure region."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name."
}

variable "tenant_id" {
  type        = string
  description = "Entra ID tenant."
  sensitive   = true
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription ID."
  sensitive   = true
}

variable "key_vault_name" {
  type        = string
  description = "Key Vault name."
}

variable "storage_account_id" {
  type        = string
  description = "Storage account name."
}

variable "storage_account_tier" {
  type        = string
  description = "Standard or Premium."
  default     = "Standard"
}

variable "storage_account_replication_type" {
  type        = string
  description = "LRS, GRS, ZRS, etc."
  default     = "LRS"
}

variable "tfstate_container_name" {
  type        = string
  description = "Terraform state container."
}

variable "user_assigned_identity_name" {
  type        = string
  description = "Managed identity name."
}

variable "role_name" {
  type        = string
  description = "Role name."
}

variable "principal_type" {
  type        = string
  description = "Principal type."
}

variable "github_organization_target" {
  type        = string
  description = "GitHub org or username."
}

variable "github_repository" {
  type        = string
  description = "GitHub repo name."
}

variable "external_secrets_sp_name" {
  type        = string
  description = "Service principal name."
  default     = "homelab-external-secrets"
}
