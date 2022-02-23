module "secondary_tde" {
  source = "./secondary"
  count  = var.is_secondary_tde == true ? 1 : 0

  key      = var.keyvault_key
  keyvault = var.secondary_keyvault
}

resource "null_resource" "set_kv_tde" {

  triggers = {
    key_id = var.is_secondary_tde == true ? module.secondary_tde[0].key_id : var.keyvault_key.id
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/set_keyvault_tde.sh", path.module)
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      KEY_ID  = var.is_secondary_tde == true ? module.secondary_tde[0].key_id : var.keyvault_key.id
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
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      RG_NAME = self.triggers.resource_group_name
      MI_NAME = self.triggers.mi_name
    }
  }

}