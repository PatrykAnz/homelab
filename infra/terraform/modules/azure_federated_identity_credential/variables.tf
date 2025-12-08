variable "name" {
  description = "The name of the federated identity credential."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "audience_name" {
  description = "The name of the audience."
  type        = string
}

variable "issuer_url" {
  description = "The URL of the issuer."
  type        = string
}

variable "user_assigned_identity_id" {
  description = "The ID of the user assigned identity."
  type        = string
}

variable "subject" {
  description = "The subject of the federated identity credential."
  type        = string
}
