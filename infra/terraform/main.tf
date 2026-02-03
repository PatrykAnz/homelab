locals {
  default_audience = "api://AzureADTokenExchange"
  github_issuer    = "https://token.actions.githubusercontent.com"

  common_tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Repository  = "${var.github_organization_target}/${var.github_repository}"
  }
}

data "azurerm_client_config" "current" {}
data "azurerm_subscription" "current" {}

resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location

  tags = local.common_tags
}

resource "azurerm_key_vault_secret" "azure_client_id" {
  name         = "azure-client-id"
  key_vault_id = module.keyvault.id
  value        = module.external_secrets_sp.client_id
  content_type = "text/plain"

  depends_on = [module.keyvault_admin_role]
}

resource "azurerm_key_vault_secret" "azure_client_secret" {
  name         = "azure-client-secret"
  key_vault_id = module.keyvault.id
  value        = module.external_secrets_sp.client_secret
  content_type = "text/plain"

  depends_on = [module.keyvault_admin_role]
}

resource "azurerm_key_vault_secret" "azure_tenant_id" {
  name         = "azure-tenant-id"
  key_vault_id = module.keyvault.id
  value        = var.tenant_id
  content_type = "text/plain"

  depends_on = [module.keyvault_admin_role]
}

resource "azurerm_key_vault_secret" "azure_key_vault_name" {
  name         = "azure-key-vault-name"
  key_vault_id = module.keyvault.id
  value        = var.key_vault_name
  content_type = "text/plain"

  depends_on = [module.keyvault_admin_role]
}

module "keyvault" {
  source = "./modules/azure_key_vault"

  name                = var.key_vault_name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location
  tenant_id           = var.tenant_id
  tags                = local.common_tags
}

module "storageaccount" {
  source = "./modules/azure_storage_account"

  name                            = var.storage_account_id
  resource_group_name             = azurerm_resource_group.resource_group.name
  location                        = var.location
  account_tier                    = var.storage_account_tier
  account_replication_type        = var.storage_account_replication_type
  allow_nested_items_to_be_public = false
  container_name                  = var.tfstate_container_name
  tags                            = local.common_tags
}

module "user_assigned_identity" {
  source = "./modules/azure_user_assigned_identity"

  name                = var.user_assigned_identity_name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location
  tags                = local.common_tags
}

module "subscription_owner_role_assignment" {
  source = "./modules/azure_role_assignment"

  scope          = data.azurerm_subscription.current.id
  role_name      = var.role_name
  principal_id   = module.user_assigned_identity.principal_id
  principal_type = var.principal_type
}

module "tfstate_role_assignment" {
  source = "./modules/azure_role_assignment"

  scope        = module.storageaccount.id
  role_name    = "Storage Blob Data Contributor"
  principal_id = module.user_assigned_identity.principal_id
}

module "keyvault_admin_role" {
  source = "./modules/azure_role_assignment"

  scope        = module.keyvault.id
  role_name    = "Key Vault Secrets Officer"
  principal_id = data.azurerm_client_config.current.object_id
}

module "external_secrets_keyvault_role" {
  source = "./modules/azure_role_assignment"

  scope        = module.keyvault.id
  role_name    = "Key Vault Secrets User"
  principal_id = module.external_secrets_sp.object_id
}

module "github_federated_credential" {
  source = "./modules/azure_federated_identity_credential"

  name                = "${var.github_organization_target}-${var.github_repository}-${var.environment}"
  resource_group_name = azurerm_resource_group.resource_group.name
  parent_id           = module.user_assigned_identity.id
  issuer              = local.github_issuer
  subject             = "repo:${var.github_organization_target}/${var.github_repository}:environment:${var.environment}"
  audience            = local.default_audience
}

module "github_federated_credential_pr" {
  source = "./modules/azure_federated_identity_credential"

  name                = "${var.github_organization_target}-${var.github_repository}-pr"
  resource_group_name = azurerm_resource_group.resource_group.name
  parent_id           = module.user_assigned_identity.id
  issuer              = local.github_issuer
  subject             = "repo:${var.github_organization_target}/${var.github_repository}:pull_request"
  audience            = local.default_audience
}

module "github_federated_credential_main" {
  source = "./modules/azure_federated_identity_credential"

  name                = "${var.github_organization_target}-${var.github_repository}-main"
  resource_group_name = azurerm_resource_group.resource_group.name
  parent_id           = module.user_assigned_identity.id
  issuer              = local.github_issuer
  subject             = "repo:${var.github_organization_target}/${var.github_repository}:ref:refs/heads/main"
  audience            = local.default_audience
}

module "external_secrets_sp" {
  source = "./modules/azure_service_principal"

  name = var.external_secrets_sp_name
}
