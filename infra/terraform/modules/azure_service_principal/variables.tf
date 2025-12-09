variable "name" {
  type        = string
  description = "Display name for the Azure AD application and service principal."
}

variable "password_rotation_days" {
  description = "Number of days until the password expires and rotates."
  type        = number
  default     = 365
}
