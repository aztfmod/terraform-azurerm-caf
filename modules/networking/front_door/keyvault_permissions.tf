
# Register Azure FrontDoor service in the directory.
#
locals {
  front_door_application_id = "ad0e1c7e-6d38-4ba4-9efd-0bc77ba9f037"
}


resource "null_resource" "front_door_service_principal" {

  provisioner "local-exec" {
    command    = format("az ad sp create --id %s", local.front_door_application_id)
    on_failure = continue
  }
}

data "azuread_service_principal" "front_door" {
  application_id = local.front_door_application_id
}

module access_policy {
  source = "../../security/keyvault_access_policies"

  client_config = var.client_config
  keyvault_id   = var.keyvault_id

  access_policies = {
    front_door_certificate = {
      object_id               = data.azuread_service_principal.front_door.object_id
      certificate_permissions = ["Get"]
      secret_permissions      = ["Get"]
    }
  }
}