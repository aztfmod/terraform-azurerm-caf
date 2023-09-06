variable "create_mode" {
  description = <<DESC
  create_mode. Allowed values are  'Default','PointInTimeRestore','Recovery','RestoreExternalBackup','RestoreLongTermRetentionBackup'
   DESC

  default  = "Local"
  nullable = false

  validation {
    condition = contains(
      [
        "Default",
        "PointInTimeRestore",
        "Recovery",
        "RestoreExternalBackup",
        "RestoreLongTermRetentionBackup"

      ],
      var.create_mode
    )
    error_message = format("Not supported value: '%s'. \nAdjust your configuration file with a supported value: %s",
      var.create_mode,
      join(", ",
        [
          "Default",
          "PointInTimeRestore",
          "Recovery",
          "RestoreExternalBackup",
          "RestoreLongTermRetentionBackup"
        ]
      )
    )
  }
}
output "create_mode" {
  value = var.create_mode
}

