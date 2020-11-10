variable global_settings {}
variable client_config {}
variable resource_groups {}
variable settings {}
variable vnets {
  default = {}
}
variable azuread_groups {
  default = {}
}
variable managed_identities {
  default = {}
}
# For diagnostics settings
variable diagnostics {
  default = {}
}
variable base_tags {}