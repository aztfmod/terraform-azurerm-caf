  dynamic "aad_admin" {
    for_each = try(var.settings.aad_admin, null) != null ? [var.settings.aad_admin] : []

    content {
      login     = try(aad_admin.value.login, null)
      object_id = try(aad_admin.value.object_id, null)
      tenant_id = try(aad_admin.value.tenant_id, null)
    }
  }