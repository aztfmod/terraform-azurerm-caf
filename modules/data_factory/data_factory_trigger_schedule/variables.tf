variable name {
  description = "(Required) Specifies the name of the Data Factory Schedule Trigger"
}

variable resource_group_name {
  description = "(Required) The name of the resource group in which to create the Data Factory Schedule Trigger"
}

variable data_factory_name {
  description = "(Required) The Data Factory name in which to associate the Schedule Trigger with"
}

variable pipeline_name {
  description = "(Required) The Data Factory Pipeline name that the trigger will act on"
}

variable start_time {
  description = "(Optional) The time the Schedule Trigger will start"
}

variable end_time {
  description = "(Optional) The time the Schedule Trigger should end"
}

variable interval {
  description = " (Optional) The interval for how often the trigger occurs. This defaults to 1"
}

variable frequency {
  description = "(Optional) The trigger freqency. Valid values include Minute, Hour, Day, Week, Month. Defaults to Minute"
}

variable pipeline_parameters {
  description = "(Optional) The pipeline parameters that the trigger will act upon"
}

variable annotations {
  description = "(Optional) List of tags that can be used for describing the Data Factory Schedule Trigger"
}