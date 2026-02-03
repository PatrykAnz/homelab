output "id" {
  value       = azurerm_key_vault.key_vault.id
  description = "Resource ID."
}

output "vault_uri" {
  value       = azurerm_key_vault.key_vault.vault_uri
  description = "Vault URI."
}
