recovery_plans = {
  plan1 = {
    name                       = "asrplan1"
    recovery_vault_key         = "asr1"
    source_recovery_fabric_key = "fabric1"
    target_recovery_fabric_key = "fabric1"
    azure_to_azure_settings = {
      primary_zone  = "1"
      recovery_zone = "2"
    }
    boot_recovery_group = {
      virtual_machines_key = ["app01"]
      # replicated_protected_items_id = ["/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/sharedsvc_re1/providers/Microsoft.RecoveryServices/vaults/vault_re1/replicationFabrics/fab_re1/replicationProtectionContainers/prtc1/replicationProtectedItems/example_vm1-repl"]
    }
    shutdown_recovery_group = {
      pre_action = {
        name                      = "testshutdownPreAction"
        type                      = "ManualActionDetails"
        fail_over_directions      = ["PrimaryToRecovery"]
        fail_over_types           = ["TestFailover"]
        manual_action_instruction = "test shutdown instruction"
      }
      post_action = {
        name                      = "testshutdownPostAction"
        type                      = "ManualActionDetails"
        fail_over_directions      = ["PrimaryToRecovery"]
        fail_over_types           = ["TestFailover"]
        manual_action_instruction = "test shutdown instruction"
      }
    }
  }
}
