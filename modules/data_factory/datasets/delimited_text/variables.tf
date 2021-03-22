variable name {
  description = "(Required) Specifies the name of the Data Factory Dataset"
}

variable resource_group_name {
  description = "(Required) The name of the resource group in which to create the Data Factory Dataset"
}

variable data_factory_name {
  description = "(Required) The Data Factory name in which to associate the Dataset with"
}

variable linked_service_name {
  description = "(Required) The Data Factory Linked Service name in which to associate the Dataset with"
}

variable folder {
  description = "(Optional) The folder that this Dataset is in. If not specified, the Dataset will appear at the root level"
}

variable schema_column {
  description = "(Optional) A schema_column block"
}

variable description {
  description = "(Optional) The description for the Data Factory Dataset"
}

variable annotations {
  description = "(Optional) List of tags that can be used for describing the Data Factory Dataset"
}

variable parameters {
  description = "(Optional) A map of parameters to associate with the Data Factory Dataset"
}

variable additional_properties {
  description = "(Optional) A map of additional properties to associate with the Data Factory Dataset"
}

variable column_delimiter {
  description = "(Required) The column delimiter"
}

variable row_delimiter {
  description = "(Required) The row delimiter"
}

variable encoding {
  description = "(Required) The encoding format for the file"
}

variable quote_character {
  description = "(Required) The quote character"
}

variable escape_character {
  description = "(Required) The escape character"
}

variable first_row_as_header {
  description = "(Required) When used as input, treat the first row of data as headers"
}

variable null_value  {
  description = "(Required) The null value string"
}

variable http_server_location {
  description = "(Required) A http_server_location block"
}

variable azure_blob_storage_location {
  description = "(Required) A azure_blob_storage_location block"
}