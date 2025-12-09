variable "name" {
  description = "Display name for the Azure AD application and service principal."
  type        = string
}

variable "password_rotation_days" {
  description = "Password expiration in relative time format (e.g., '8760h' for 1 year)."
  type        = string
  default     = "8760h"
}
