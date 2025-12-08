output "user_assinged_identity_id" {
  value       = azurerm_user_assigned_identity.user_assigned_identity.id
  description = "ID of the user-assigned managed identity."
}

output "user_assinged_identity_principal_id" {
  value       = azurerm_user_assigned_identity.user_assigned_identity.principal_id
  description = "Principal ID of the user-assigned managed identity"
}

output "user_assigned_identity_client_id" {
  value       = azurerm_user_assigned_identity.user_assigned_identity.client_id
  description = "Client ID of the user-assigned managed identity (used for OIDC authentication)"
}
