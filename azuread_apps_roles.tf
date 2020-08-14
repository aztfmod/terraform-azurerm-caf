locals {
  azuread_roles = flatten(
    [
      for key, azuread_roles in var.azuread_roles : [
        for role in azuread_roles.roles : {
          aad_app_key   = key
          aad_role_name = role
        }
      ]
    ]
  )
}



resource "null_resource" "set_azure_ad_roles" {
  depends_on = [module.azuread_applications]

  for_each = {
    for key, aad_role in local.azuread_roles : key => aad_role
  }

  provisioner "local-exec" {
    command     = "./scripts/set_ad_role.sh"
    interpreter = ["/bin/sh"]
    on_failure  = fail

    environment = {
      AD_ROLE_NAME                = each.value.aad_role_name
      SERVICE_PRINCIPAL_OBJECT_ID = module.azuread_applications.aad_apps[each.value.aad_app_key].azuread_service_principal.object_id
    }
  }
}