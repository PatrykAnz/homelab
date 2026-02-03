output "github_oidc_client_id" {
  value       = module.user_assigned_identity.client_id
  description = "AZURE_CLIENT_ID value."
}

output "azure_tenant_id" {
  value       = var.tenant_id
  description = "AZURE_TENANT_ID value."
  sensitive   = true
}

output "azure_subscription_id" {
  value       = var.subscription_id
  description = "AZURE_SUBSCRIPTION_ID value."
  sensitive   = true
}

output "azure_resource_group" {
  value       = azurerm_resource_group.resource_group.name
  description = "Resource group name."
}

output "azure_storage_account" {
  value       = module.storageaccount.name
  description = "Storage account name."
}

output "azure_tfstate_container" {
  value       = var.tfstate_container_name
  description = "Terraform state container."
}

output "azure_key_vault_name" {
  value       = var.key_vault_name
  description = "Key Vault name."
}
