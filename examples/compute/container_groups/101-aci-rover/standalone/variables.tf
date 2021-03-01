variable global_settings {
  default = {}
}

variable resource_groups {
  default = null
}

variable vnets {
  default = {}
}

variable tags {
  default = null
  type    = map
}

variable diagnostic_log_analytics {
  default = {}
}

variable network_security_group_definition {
  default = {}
}

variable container_groups {
  default = {}
}

variable managed_identities {
  default = {}
}
variable keyvaults {
  default = {}
}
variable dynamic_keyvault_secrets {
  default = {}
}
variable role_mapping {
  default = {}
}