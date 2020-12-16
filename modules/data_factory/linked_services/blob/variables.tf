variable name {
  description = "(Required) Specifies the name of the Data Factory Linked Service"
}

variable resource_group_name {
  description = "(Required) The name of the resource group in which to create the Data Factory Linked Service"
}

variable data_factory_name {
  description = "(Required) The Data Factory name in which to associate the Linked Service with. Changing this forces a new resource"
}


variable description {
  description = "(Optional) The description for the Data Factory Linked Service"
}

variable integration_runtime_name {
  description = "(Optional) The integration runtime reference to associate with the Data Factory Linked Service"
}

variable annotations {
  description = "(Optional) List of tags that can be used for describing the Data Factory Linked Service"
}

variable parameters {
  description = "(Optional) A map of parameters to associate with the Data Factory Linked Service"
}

variable additional_properties {
  description = "(Optional) A map of additional properties to associate with the Data Factory Linked Service"
}

variable connection_string {
  description = "(Optional) The connection string. Required if account_endpoint, account_key, and database are unspecified"
}