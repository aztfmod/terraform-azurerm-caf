variable "mi_create_mode" {
  description = "	Specifies the mode of database creation. Default: Regular instance creation. Restore: Creates an instance by restoring a set of backups to specific point in time. RestorePointInTime and SourceManagedInstanceId must be specified."
  default     = "Default"
  nullable    = true

  validation {
    condition = contains(
      [
        "Default",
        "PointInTimeRestore"
      ],
      var.mi_create_mode
    )
    error_message = format("Not supported value: '%s'. \nAdjust your configuration file with a supported value: %s",
      var.mi_create_mode,
      join(", ",
        [
          "Default",
          "PointInTimeRestore"
        ]
      )
    )
  }
}
output "mi_create_mode" {
  value = var.mi_create_mode
}
#