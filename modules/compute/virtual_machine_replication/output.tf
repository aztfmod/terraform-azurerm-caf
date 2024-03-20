output "replicated_objects_id" {
    value = {
        for key, value in azurerm_site_recovery_replicated_vm.replication : key => value.id
    }
}