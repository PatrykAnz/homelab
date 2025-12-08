variable "principal_id" {
  description = "The ID of the principal to assign the role to."
  type        = string
}

variable "principal_type" {
  description = "The type of the principal to assign the role to."
  type        = string
}

variable "role_name" {
  description = "The name of the role to assign to the principal."
  type        = string
}

variable "scope_id" {
  description = "The ID of the scope to assign the role to."
  type        = string
}
