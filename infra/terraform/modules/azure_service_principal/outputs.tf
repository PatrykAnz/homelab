output "client_id" {
  value       = azuread_application.app.client_id
  description = "Application client ID."
}

output "client_secret" {
  value       = azuread_service_principal_password.sp_password.value
  description = "Service principal secret."
  sensitive   = true
}

output "object_id" {
  value       = azuread_service_principal.sp.object_id
  description = "Service principal ID."
}

output "application_id" {
  value       = azuread_application.app.id
  description = "Application object ID."
}
