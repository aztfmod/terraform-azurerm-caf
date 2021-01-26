variable global_settings {
  default = {}
}

variable resource_groups {
  default = null
}

variable tags {
  default = null
  type    = map
}

variable azure_container_registries {
  default = {}
}

variable log_analytics {
  default = {}
}

variable diagnostics_destinations {
  default = {}
}

variable diagnostics_definition {
  default = {}
}

variable var_folder_path {
  default = {}
}