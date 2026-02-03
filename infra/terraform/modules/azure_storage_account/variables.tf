variable "name" {
  type        = string
  description = "Storage account name."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name."
}

variable "location" {
  type        = string
  description = "Azure region."
}

variable "account_tier" {
  type        = string
  description = "Standard or Premium."
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "Must be Standard or Premium."
  }
}

variable "account_replication_type" {
  type        = string
  description = "LRS, GRS, ZRS, etc."
  default     = "LRS"

  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.account_replication_type)
    error_message = "Invalid replication type."
  }
}

variable "min_tls_version" {
  type        = string
  description = "Minimum TLS version."
  default     = "TLS1_2"

  validation {
    condition     = contains(["TLS1_0", "TLS1_1", "TLS1_2"], var.min_tls_version)
    error_message = "Must be TLS1_0, TLS1_1, or TLS1_2."
  }
}

variable "allow_nested_items_to_be_public" {
  type        = bool
  description = "Allow public blob access."
  default     = false
}

variable "container_name" {
  type        = string
  description = "Blob container name."
}

variable "tags" {
  type        = map(string)
  description = "Resource tags."
  default     = {}
}
