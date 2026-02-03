output "id" {
  value       = azurerm_storage_account.storage_account.id
  description = "Resource ID."
}

output "name" {
  value       = azurerm_storage_account.storage_account.name
  description = "Storage account name."
}

output "primary_blob_endpoint" {
  value       = azurerm_storage_account.storage_account.primary_blob_endpoint
  description = "Blob endpoint URL."
}

output "primary_access_key" {
  value       = azurerm_storage_account.storage_account.primary_access_key
  description = "Storage access key."
  sensitive   = true
}
