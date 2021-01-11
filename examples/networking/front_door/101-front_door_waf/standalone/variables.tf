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

variable front_door_waf_policies {
  default = {}
}

variable front_doors  {
  default = {}
}

variable keyvaults {
  default = {}  
}

variable var_folder_path {
  default = {}
}