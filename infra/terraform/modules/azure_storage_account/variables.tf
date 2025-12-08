variable "name" {
  type        = string
  description = "Storage account name."
}

variable "location" {
  type        = string
  description = "Azure region."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name."
}

variable "account_tier" {
  type        = string
  description = "Performance tier (Standard or Premium)."
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  description = "Replication type."
  default     = "LRS"
}

variable "min_tls_version" {
  type        = string
  description = "Minimum TLS version for the storage account."
  default     = "TLS1_2"
}


variable "allow_nested_items_to_be_public" {
  type        = bool
  description = "Whether to allow public access to nested items (containers/blobs)."
  default     = false
}

variable "container_name" {
  type        = string
  description = "Name of the storage container to create."
}
