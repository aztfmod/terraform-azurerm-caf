variable "backup_storage_redundancy" {
  description = "backup_storage_redundancy. Allowed values are  'Geo','GeoZone','Local','Zone'"
  default     = "Local"
  nullable    = false

  validation {
    condition = contains(
      [
        "GRS",
        "LRS",
        "ZRS"
      ],
      var.backup_storage_redundancy
    )
    error_message = format("Not supported value: '%s'. \nAdjust your configuration file with a supported value: %s",
      var.backup_storage_redundancy,
      join(", ",
        [
          "GRS",
          "LRS",
          "ZRS"
        ]
      )
    )
  }
}
output "backup_storage_redundancy" {
  value = var.backup_storage_redundancy
}
#