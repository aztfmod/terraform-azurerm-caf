variable resource_id {}

variable name {
  type        = string
  description = "(Required) Specifies the name of the Container Registry. Changing this forces a new resource to be created."
}

variable resource_group_name {
  description = "(Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created."
}

variable location {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable subnet_id {}
variable settings {}
variable global_settings {}
variable base_tags {}