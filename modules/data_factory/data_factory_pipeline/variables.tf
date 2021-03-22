variable name {
  description = "(Required) Specifies the name of the Data Factory Pipeline"
}

variable resource_group_name {
  description = "(Required) The name of the resource group in which to create the Data Factory Pipeline"
}

variable data_factory_name {
  description = "(Required) The Data Factory name in which to associate the Pipeline with. Changing this forces a new resource"
}

variable description {
  description = "(Optional) The description for the Data Factory Pipeline"
}

variable annotations {
  description = "(Optional) List of tags that can be used for describing the Data Factory Pipeline"
}

variable parameters {
  description = "(Optional) A map of parameters to associate with the Data Factory Pipeline"
}

variable variables {
  description = "(Optional) A map of variables to associate with the Data Factory Pipeline"
}

variable activities_json {
  description = "(Optional) A JSON object that contains the activities that will be associated with the Data Factory Pipeline"
}
