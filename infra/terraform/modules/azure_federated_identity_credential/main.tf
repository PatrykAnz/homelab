resource "azurerm_federated_identity_credential" "cred" {
  name                = var.name
  resource_group_name = var.resource_group_name
  parent_id           = var.parent_id

  issuer   = var.issuer
  subject  = var.subject
  audience = [var.audience]
}
