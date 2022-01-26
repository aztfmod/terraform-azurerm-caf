# Admin consent management is not performed in the same way if the logged in user is a service principal or a user
# We have two local variables to accomodate that.
locals {

  api_permissions_for_sp = {
    for api_permission in
    flatten(
      [
        for key, resources in var.azuread_api_permissions : [
          for resource_name, resource in resources.resource_access : {
            aad_app_key     = key
            resource_name   = resource_name
            resource_app_id = resources.resource_app_id
            id              = resource.id
            type            = resource.type
          } if resource.type == "Role"
        ]
      ]
    ) : format("%s-%s", api_permission.aad_app_key, api_permission.resource_name) => api_permission
  }

  api_permissions_for_user = {
    for api_permission in
    distinct(
      flatten(
        [
          for key, resources in var.azuread_api_permissions : [
            for resource in resources.resource_access : {
              aad_app_key = key
            }
          ]
        ]
      )
    ) : api_permission.aad_app_key => api_permission
  }

  ### Fltattening the list to only the applications when granting concent with a logged-in user type user
  # value = [
  #   {"aad_app_key" = "aztfmod_level0" },
  #   {"aad_app_key" = "azure_caf-terraform-landingzones"},
  # ]

  api_permissions = var.user_type == "user" ? local.api_permissions_for_user : local.api_permissions_for_sp

}

resource "time_sleep" "wait_for_directory_propagation" {
  depends_on = [azuread_service_principal.app]

  create_duration = "65s"
}

resource "null_resource" "grant_admin_consent" {
  depends_on = [time_sleep.wait_for_directory_propagation]

  for_each = {
    for key, permission in local.api_permissions : key => permission
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/grant_consent.sh", path.module)
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      resourceAppId = var.user_type == "user" ? null : each.value.resource_app_id
      appRoleId     = var.user_type == "user" ? null : each.value.id
      principalId   = var.user_type == "user" ? null : azuread_service_principal.app.id
      applicationId = azuread_application.app.application_id
    }
  }
}
