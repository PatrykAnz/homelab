output "client_id" {
  value       = azuread_application.app.client_id
  description = "The Application (client) ID."
}

output "client_secret" {
  value       = azuread_service_principal_password.sp_password.value
  description = "The client secret value."
  sensitive   = true
}

output "object_id" {
  value       = azuread_service_principal.sp.object_id
  description = "The Object ID of the service principal."
}

output "application_id" {
  value       = azuread_application.app.id
  description = "The Application Object ID."
}

output "password_rotation_due" {
  value       = time_rotating.sp_password_rotation.rotation_rfc3339
  description = "When the next terraform apply will rotate the password (RFC 3339)."
}

output "password_expires" {
  value       = azuread_service_principal_password.sp_password.end_date
  description = "Hard expiry of the current password (RFC 3339)."
}
