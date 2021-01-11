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

variable aks_clusters  {
  default = {}
}

variable virtual_machines {
  default = {}
}

variable network_security_group_definition {
  default = {}
}

variable var_folder_path {
  default = {}
}
