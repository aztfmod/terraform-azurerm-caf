# # TODO 
# resource "azurerm_backup_policy_vm" "example" {
#   name                = "tfex-recovery-vault-policy"
#   resource_group_name = azurerm_resource_group.example.name
#   recovery_vault_name = azurerm_recovery_services_vault.example.name

#   timezone = "UTC"

#   backup {
#     frequency = "Daily"
#     time      = "23:00"
#   }

#   retention_daily {
#     count = 10
#   }

#   retention_weekly {
#     count    = 42
#     weekdays = ["Sunday", "Wednesday", "Friday", "Saturday"]
#   }

#   retention_monthly {
#     count    = 7
#     weekdays = ["Sunday", "Wednesday"]
#     weeks    = ["First", "Last"]
#   }

#   retention_yearly {
#     count    = 77
#     weekdays = ["Sunday"]
#     weeks    = ["Last"]
#     months   = ["January"]
#   }
# }

# resource "azurerm_backup_policy_file_share" "policy" {
#   name                = "tfex-recovery-vault-policy"
#   resource_group_name = azurerm_resource_group.rg.name
#   recovery_vault_name = azurerm_recovery_services_vault.vault.name

#   timezone = "UTC"

#   backup {
#     frequency = "Daily"
#     time      = "23:00"
#   }

#   retention_daily {
#     count = 10
#   }
# }