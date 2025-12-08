output "id" {
  description = "ID of the Key Vault."
  value       = azurerm_key_vault.kv.id
}

output "vault_uri" {
  description = "Vault URI for secret operations."
  value       = azurerm_key_vault.kv.vault_uri
}
