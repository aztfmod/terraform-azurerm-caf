variable name {
  description = "(Required) The name which should be used for this Logic App Integration Account"
}

variable resource_group_name {
  description = "(Required) The name of the Resource Group where the Logic App Integration Account should exist"
}

variable location {
  description = "(Required) The Azure Region where the Logic App Integration Account should exist"
}

variable sku_name {
  description = "(Required) The sku name of the Logic App Integration Account. Possible Values are Basic, Free and Standard"
}

variable tags {
  description = "(Optional) A mapping of tags which should be assigned to the Logic App Integration Account"
}

variable global_settings {}

variable base_tags {}