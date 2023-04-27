

resource "null_resource" "create_sec_tde_key" {

  triggers = {
    primary_key_id = var.key.id
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/create_tde_key_secondary.sh", path.module)
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      PRIMARY_KEY_ID = var.key.id
      KEYVAULT_NAME  = var.keyvault.name
    }
  }
}

data "azurerm_key_vault_key" "secondary_key" {
  depends_on = [null_resource.create_sec_tde_key]

  name         = var.key.name
  key_vault_id = var.keyvault.id
}


resource "null_resource" "delete_sec_tde_key" {

  triggers = {
    key_name      = var.key.name
    keyvault_name = var.keyvault.name
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/delete_tde_key_secondary.sh", path.module)
    when        = destroy
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      KEY_NAME      = self.triggers.key_name
      KEYVAULT_NAME = self.triggers.keyvault_name
    }
  }

}