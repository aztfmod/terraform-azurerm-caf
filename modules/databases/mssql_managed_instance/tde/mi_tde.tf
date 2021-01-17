

resource "null_resource" "set_kv_tde" {

  triggers = {
    key_uri = var.key_uri
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/set_keyvault_tde.sh", path.module)
    interpreter = ["/bin/sh"]
    on_failure  = fail

    environment = {
      KEY_URI = var.key_uri
      RG_NAME = var.resource_group_name
      MI_NAME = var.mi_name
    }
  }
}



resource "null_resource" "reset_tde" {

  triggers = {
    resource_group_name = var.resource_group_name
    mi_name             = var.mi_name
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/reset_tde.sh", path.module)
    when        = destroy
    interpreter = ["/bin/sh"]
    on_failure  = fail

    environment = {
      RG_NAME = self.triggers.resource_group_name
      MI_NAME = self.triggers.mi_name
    }
  }

}