variable "name" {
  type        = string
  description = "Application name."
}

variable "password_rotation_days" {
  type        = number
  description = "Password validity days."
  default     = 365
}
