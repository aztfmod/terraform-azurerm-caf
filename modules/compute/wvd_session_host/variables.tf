variable global_settings {
  description = "Global settings object (see module README.md)"
}
variable client_config {
  default = {}
}
variable settings {}
variable base_tags {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map
}
variable resource_group_name {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}
variable location {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}


variable key_vault_id {
  default = {}
}

variable keyvaults {
  default = {}
  
}

variable vnets {
  default = {}
}

variable host_pool_name {}
  




