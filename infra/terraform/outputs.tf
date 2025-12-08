# Outputs for GitHub Actions OIDC Configuration
# After running terraform apply, use these values to configure GitHub repository variables

output "github_oidc_client_id" {
  value       = module.user_assigned_identity.user_assigned_identity_client_id
  description = "Client ID for GitHub OIDC authentication (AZURE_CLIENT_ID)"
}

output "azure_tenant_id" {
  value       = var.tenant_id
  description = "Azure Tenant ID (AZURE_TENANT_ID)"
  sensitive   = true
}

output "azure_subscription_id" {
  value       = var.subscription_id
  description = "Azure Subscription ID (AZURE_SUBSCRIPTION_ID)"
  sensitive   = true
}

output "azure_resource_group" {
  value       = azurerm_resource_group.resource_group.name
  description = "Resource Group name (AZURE_RESOURCE_GROUP)"
}

output "azure_storage_account" {
  value       = module.storageaccount.name
  description = "Storage Account name for tfstate (AZURE_STORAGE_ACCOUNT)"
}

output "azure_tfstate_container" {
  value       = var.tfstate_container_name
  description = "Container name for tfstate (AZURE_TFSTATE_CONTAINER)"
}

output "azure_key_vault_name" {
  value       = var.key_vault_name
  description = "Key Vault name (AZURE_KEY_VAULT_NAME)"
}
