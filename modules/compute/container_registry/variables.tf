variable global_settings {}

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

variable admin_enabled {
  description = "(Optional) Specifies whether the admin user is enabled. Defaults to false."
  default     = false
}

variable sku {
  description = "(Optional) The SKU name of the container registry. Possible values are Basic, Standard and Premium. Defaults to Basic"
  default     = "Basic"
}

variable tags {
  type        = map
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}

variable georeplication_locations {
  description = "(Optional) A list of Azure locations where the container registry should be geo-replicated."
  default     = null
}

variable vnets {
  default = {}
}

variable network_rule_set {
  description = " (Optional) A network_rule_set block as documented https://www.terraform.io/docs/providers/azurerm/r/container_registry.html"
  default     = {}
}

variable diagnostic_profiles {
  default = {}
}

variable diagnostics {
  default = {}
}

variable private_endpoints {
  default = {}
}

variable resource_groups {
  default = {}
}

variable tfstates {}
variable use_msi {
  default = false
}

variable base_tags {}