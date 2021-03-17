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

variable public_ip_addresses {
  default = {}
}

variable virtual_network_gateways {
  default = {}
}

# variable var_folder_path {
#   default = {}
# }

variable load_balancers {
  default = {}
}

variable load_balancer_rules {
  default = {}
}

variable load_balancer_probe {
  default = {}
}
variable var_folder_path {
  default = {}
}

variable "virtual_machines" {
  default = {}
}

variable keyvault_access_policies {}

variable keyvaults {}