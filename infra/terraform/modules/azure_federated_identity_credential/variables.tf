variable "name" {
  type        = string
  description = "Credential name."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name."
}

variable "parent_id" {
  type        = string
  description = "Managed identity ID."
}

variable "issuer" {
  type        = string
  description = "Token issuer URL."
}

variable "subject" {
  type        = string
  description = "Subject claim."
}

variable "audience" {
  type        = string
  description = "Token audience."
  default     = "api://AzureADTokenExchange"
}
