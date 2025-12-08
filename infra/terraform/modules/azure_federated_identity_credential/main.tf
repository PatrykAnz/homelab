resource "azurerm_federated_identity_credential" "cred" {
  name = var.name
  resource_group_name = var.resource_group_name
  audience = [ var.audience_name ]
  issuer = var.issuer_url
  parent_id = var.user_assigned_identity_id
  subject = var.subject
}
