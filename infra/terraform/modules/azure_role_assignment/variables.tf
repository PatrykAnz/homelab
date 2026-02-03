variable "scope" {
  type        = string
  description = "Assignment scope."
}

variable "role_name" {
  type        = string
  description = "Role definition name."
}

variable "principal_id" {
  type        = string
  description = "Principal object ID."
}

variable "principal_type" {
  type        = string
  description = "User, Group, or SP."
  default     = "ServicePrincipal"

  validation {
    condition     = contains(["User", "Group", "ServicePrincipal"], var.principal_type)
    error_message = "Must be User, Group, or ServicePrincipal."
  }
}
