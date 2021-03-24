variable name {
  description = "(Required) The name of the Integration Service Environment"
}

variable location {
  description = "(Required) The Azure Region where the Integration Service Environment should exist"
}

variable resource_group_name {
  description = "(Required) The name of the Resource Group where the Integration Service Environment should exist"
}

variable sku_name {
  description = "(Required) The sku name and capacity of the Integration Service Environment"
}

variable access_endpoint_type {
  description = "(Required) The type of access endpoint to use for the Integration Service Environment"
}

variable virtual_network_subnet_ids {
  description = "(Required) A list of virtual network subnet ids to be used by Integration Service Environment"
}

variable tags {
  description = "(Optional) A mapping of tags which should be assigned to the Integration Service Environment"
}

variable global_settings {}

variable base_tags {}