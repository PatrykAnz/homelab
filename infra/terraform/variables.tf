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
  description = "Azure AD tenant ID."
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
  description = "Storage account tier."
  default     = "Standard"
}

variable "storage_account_replication_type" {
  type        = string
  description = "Storage replication type."
  default     = "LRS"
}

variable "tfstate_container_name" {
  type        = string
  description = "TFState container name."
}

variable "user_assigned_identity_name" {
  type        = string
  description = "User assigned identity name."
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
  description = "GitHub organization target."
}

variable "github_repository" {
  type        = string
  description = "GitHub repository."
}

variable "environment" {
  type        = string
  description = "Environment."
}

variable "external_secrets_sp_name" {
  type        = string
  description = "Name for the External Secrets Operator service principal."
  default     = "homelab-external-secrets"
}
