# variable keyvault_certificate_issuers {
#   default = {}
# }
# variable resource_group_name {}


variable global_settings {}
variable client_config {}
variable settings {}
variable resource_group_name {}
variable location {}
variable storage_accounts {}
variable azuread_groups {}
variable vnets {}
variable private_endpoints {}
variable resource_groups {}
variable base_tags {}
variable keyvaults {
  default = {}
}
variable keyvault_key {
  default = null
}


variable keyvault_id {
  default = null
}
