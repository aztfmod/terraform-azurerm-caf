moved {
  from = module.example.module.azuread_groups
  to   = module.example.module.azuread_graph_group
}
moved {
  from = module.example.module.azuread_groups_membership
  to   = module.example.module.azuread_graph_group_member
}
moved {
  from = module.example.module.azuread_applications_v1
  to   = module.example.module.azuread_graph_application
}
moved {
  from = module.example.module.azuread_users
  to   = module.example.module.azuread_graph_user
}
moved {
  from = module.example.module.azuread_service_principals
  to   = module.example.module.azuread_graph_service_principal
}
moved {
  from = module.example.module.azuread_service_principal_passwords
  to   = module.example.module.azuread_graph_service_principal_password
}