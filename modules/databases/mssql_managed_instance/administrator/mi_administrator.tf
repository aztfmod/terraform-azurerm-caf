
data "azuread_user" "upn" {
  count = try(var.user_principal_name, null) == null ? 0 : 1

  user_principal_name = var.user_principal_name
}

resource "null_resource" "set_mi_ad_admin" {

  triggers = {
    object_id = local.object_id
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/set_mi_ad_admin.sh", path.module)
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      OBJECT_ID    = local.object_id
      DISPLAY_NAME = local.display_name
      RG_NAME      = var.resource_group_name
      MI_NAME      = var.mi_name
    }
  }
}
