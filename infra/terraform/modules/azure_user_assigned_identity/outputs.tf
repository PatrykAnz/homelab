output "id" {
  value       = azurerm_user_assigned_identity.user_assigned_identity.id
  description = "Resource ID."
}

output "principal_id" {
  value       = azurerm_user_assigned_identity.user_assigned_identity.principal_id
  description = "Principal object ID."
}

output "client_id" {
  value       = azurerm_user_assigned_identity.user_assigned_identity.client_id
  description = "Client ID for OIDC."
}
