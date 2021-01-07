variable name {
  description = "(Required) Specifies the name of the Recurrence Triggers to be created within the Logic App Workflow"
}

variable logic_app_id {
  description = "(Required) Specifies the ID of the Logic App Workflow"
}

variable frequency {
  description = "(Required) Specifies the Frequency at which this Trigger should be run"
}

variable interval {
  description = "(Required) Specifies interval used for the Frequency"
}

variable start_time {
  description = "(Optional) Specifies the start date and time for this trigger in RFC3339 format: 2000-01-02T03:04:05Z"
}

# variable time_zone {
#   description = "(Optional) Specifies the time zone for this trigger"
# }
