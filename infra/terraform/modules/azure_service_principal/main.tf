resource "azuread_application" "app" {
  display_name = var.name
}

resource "azuread_service_principal" "sp" {
  client_id = azuread_application.app.client_id
}

resource "time_rotating" "sp_password_rotation" {
  rotation_days = var.password_rotation_days
}

resource "azuread_service_principal_password" "sp_password" {
  service_principal_id = azuread_service_principal.sp.id
  display_name         = "${var.name}-secret"
  end_date             = timeadd(time_rotating.sp_password_rotation.rotation_rfc3339, "${var.password_rotation_days * 24}h")

  rotate_when_changed = {
    rotation = time_rotating.sp_password_rotation.id
  }
}
