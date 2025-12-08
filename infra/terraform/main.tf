locals {
  default_audience_name = "api://AzureADTokenExchange"
  github_issuer_url     = "https://token.actions.githubusercontent.com"
}

data "azurerm_subscription" "current" {}

resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
}

module "keyvault" {
  source              = "./modules/azure_key_vault"
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
}

module "storageaccount" {
  source                          = "./modules/azure_storage_account"
  name                            = var.storage_account_id
  location                        = var.location
  resource_group_name             = var.resource_group_name
  account_tier                    = var.storage_account_tier
  account_replication_type        = var.storage_account_replication_type
  allow_nested_items_to_be_public = false
  container_name                  = var.tfstate_container_name
}

module "user_assigned_identity" {
  source              = "./modules/azure_user_assigned_identity"
  name                = var.user_assigned_identity_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "subscription_owner_role_assignment" {
  source         = "./modules/azure_role_assignment"
  principal_id   = module.user_assigned_identity.user_assinged_identity_principal_id
  role_name      = var.role_name
  scope_id       = data.azurerm_subscription.current.id
  principal_type = var.principal_type
}

module "github_federated_credential" {
  source                    = "./modules/azure_federated_identity_credential"
  name                      = "${var.github_organization_target}-${var.github_repository}-${var.environment}"
  resource_group_name       = var.resource_group_name
  user_assigned_identity_id = module.user_assigned_identity.user_assinged_identity_id
  subject                   = "repo:${var.github_organization_target}/${var.github_repository}:environment:${var.environment}"
  audience_name             = local.default_audience_name
  issuer_url                = local.github_issuer_url
}

module "github_federated_credential-pr" {
  source                    = "./modules/azure_federated_identity_credential"
  name                      = "${var.github_organization_target}-${var.github_repository}-pr"
  resource_group_name       = var.resource_group_name
  user_assigned_identity_id = module.user_assigned_identity.user_assinged_identity_id
  subject                   = "repo:${var.github_organization_target}/${var.github_repository}:pull_request"
  audience_name             = local.default_audience_name
  issuer_url                = local.github_issuer_url
}

module "tfstate_role_assignment" {
  source         = "./modules/azure_role_assignment"
  principal_id   = module.user_assigned_identity.user_assinged_identity_principal_id
  principal_type = var.principal_type
  role_name      = var.role_name
  scope_id       = module.storageaccount.primary_blob_endpoint
}
