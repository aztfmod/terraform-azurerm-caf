resource "azurerm_site_recovery_replication_recovery_plan" "replication_plan" {

  name                      = var.settings.name
  recovery_vault_id         = var.recovery_vault_id
  source_recovery_fabric_id = var.recovery_fabrics[var.settings.source_recovery_fabric_key].id
  target_recovery_fabric_id = var.recovery_fabrics[var.settings.target_recovery_fabric_key].id


  dynamic "shutdown_recovery_group" {
    for_each = try(var.settings.shutdown_recovery_group, null) != null ? [var.settings.shutdown_recovery_group] : []
    content {
      dynamic "pre_action" {
        for_each = can(var.settings.shutdown_recovery_group.pre_action) ? [var.settings.shutdown_recovery_group.pre_action] : []
        content {
          name                      = pre_action.value.name
          type                      = pre_action.value.type                       # (Required) Type of the action detail. Possible values are AutomationRunbookActionDetails, ManualActionDetails and ScriptActionDetails.
          fail_over_directions      = pre_action.value.fail_over_directions       # (Required) Directions of fail over. Possible values are PrimaryToRecovery and RecoveryToPrimary
          fail_over_types           = pre_action.value.fail_over_types            # (Required) Types of fail over. Possible values are TestFailover, PlannedFailover and UnplannedFailover
          fabric_location           = try(pre_action.value.fabric_location, null) # (Optional) The fabric location of runbook or script. Possible values are Primary and Recovery. It must not be specified when type is ManualActionDetails.
          runbook_id                = try(pre_action.value.runbook_id, null)
          manual_action_instruction = try(pre_action.value.manual_action_instruction, null)
          script_path               = try(pre_action.value.script_path, null)
        }
      }

      dynamic "post_action" {
        for_each = can(var.settings.shutdown_recovery_group.post_action) ? [var.settings.shutdown_recovery_group.post_action] : []
        content {
          name                      = post_action.value.name
          type                      = post_action.value.type                       # (Required) Type of the action detail. Possible values are AutomationRunbookActionDetails, ManualActionDetails and ScriptActionDetails.
          fail_over_directions      = post_action.value.fail_over_directions       # (Required) Directions of fail over. Possible values are PrimaryToRecovery and RecoveryToPrimary
          fail_over_types           = post_action.value.fail_over_types            # (Required) Types of fail over. Possible values are TestFailover, PlannedFailover and UnplannedFailover
          fabric_location           = try(post_action.value.fabric_location, null) # (Optional) The fabric location of runbook or script. Possible values are Primary and Recovery. It must not be specified when type is ManualActionDetails.
          runbook_id                = try(post_action.value.runbook_id, null)
          manual_action_instruction = try(post_action.value.manual_action_instruction, null)
          script_path               = try(post_action.value.script_path, null)
        }
      }
    }
  }

  dynamic "failover_recovery_group" {
    for_each = try(var.settings.failover_recovery_group, null) != null ? [var.settings.failover_recovery_group] : []
    content {
      dynamic "pre_action" {
        for_each = can(var.settings.failover_recovery_group.pre_action) ? [var.settings.failover_recovery_group.pre_action] : []
        content {
          name                      = pre_action.value.name
          type                      = pre_action.value.type                       # (Required) Type of the action detail. Possible values are AutomationRunbookActionDetails, ManualActionDetails and ScriptActionDetails.
          fail_over_directions      = pre_action.value.fail_over_directions       # (Required) Directions of fail over. Possible values are PrimaryToRecovery and RecoveryToPrimary
          fail_over_types           = pre_action.value.fail_over_types            # (Required) Types of fail over. Possible values are TestFailover, PlannedFailover and UnplannedFailover
          fabric_location           = try(pre_action.value.fabric_location, null) # (Optional) The fabric location of runbook or script. Possible values are Primary and Recovery. It must not be specified when type is ManualActionDetails.
          runbook_id                = try(pre_action.value.runbook_id, null)
          manual_action_instruction = try(pre_action.value.manual_action_instruction, null)
          script_path               = try(pre_action.value.script_path, null)
        }
      }

      dynamic "post_action" {
        for_each = can(var.settings.failover_recovery_group.post_action) ? [var.settings.failover_recovery_group.post_action] : []
        content {
          name                      = post_action.value.name
          type                      = post_action.value.type                       # (Required) Type of the action detail. Possible values are AutomationRunbookActionDetails, ManualActionDetails and ScriptActionDetails.
          fail_over_directions      = post_action.value.fail_over_directions       # (Required) Directions of fail over. Possible values are PrimaryToRecovery and RecoveryToPrimary
          fail_over_types           = post_action.value.fail_over_types            # (Required) Types of fail over. Possible values are TestFailover, PlannedFailover and UnplannedFailover
          fabric_location           = try(post_action.value.fabric_location, null) # (Optional) The fabric location of runbook or script. Possible values are Primary and Recovery. It must not be specified when type is ManualActionDetails.
          runbook_id                = try(post_action.value.runbook_id, null)
          manual_action_instruction = try(post_action.value.manual_action_instruction, null)
          script_path               = try(post_action.value.script_path, null)
        }
      }
    }
  }

  dynamic "boot_recovery_group" {
    for_each = try(var.settings.boot_recovery_group, null) != null ? [var.settings.boot_recovery_group] : []
    content {
      replicated_protected_items = flatten(try(
        # [for vm_key in var.settings.boot_recovery_group.virtual_machines_key : var.virtual_machines_replication[var.client_config.landingzone_key][vm_key].id] :        
        [for vm_key in var.settings.boot_recovery_group.virtual_machines_key : var.virtual_machines_replication[var.client_config.landingzone_key][vm_key].replicated_object_id],
        var.settings.boot_recovery_group.replicated_protected_items_id
        )
      )

      dynamic "pre_action" {
        # for_each = try(var.settings.boot_recovery_group.value.pre_action, null) != null ? [1] : []
        for_each = can(var.settings.boot_recovery_group.pre_action) ? [var.settings.boot_recovery_group.pre_action] : []
        content {
          name                      = pre_action.value.name
          type                      = pre_action.value.type                       # (Required) Type of the action detail. Possible values are AutomationRunbookActionDetails, ManualActionDetails and ScriptActionDetails.
          fail_over_directions      = pre_action.value.fail_over_directions       # (Required) Directions of fail over. Possible values are PrimaryToRecovery and RecoveryToPrimary
          fail_over_types           = pre_action.value.fail_over_types            # (Required) Types of fail over. Possible values are TestFailover, PlannedFailover and UnplannedFailover
          fabric_location           = try(pre_action.value.fabric_location, null) # (Optional) The fabric location of runbook or script. Possible values are Primary and Recovery. It must not be specified when type is ManualActionDetails.
          runbook_id                = try(pre_action.value.runbook_id, null)
          manual_action_instruction = try(pre_action.value.manual_action_instruction, null)
          script_path               = try(pre_action.value.script_path, null)
        }
      }

      dynamic "post_action" {
        for_each = can(var.settings.boot_recovery_group.post_action) ? [var.settings.boot_recovery_group.post_action] : []
        content {
          name                      = post_action.value.name
          type                      = post_action.value.type                       # (Required) Type of the action detail. Possible values are AutomationRunbookActionDetails, ManualActionDetails and ScriptActionDetails.
          fail_over_directions      = post_action.value.fail_over_directions       # (Required) Directions of fail over. Possible values are PrimaryToRecovery and RecoveryToPrimary
          fail_over_types           = post_action.value.fail_over_types            # (Required) Types of fail over. Possible values are TestFailover, PlannedFailover and UnplannedFailover
          fabric_location           = try(post_action.value.fabric_location, null) # (Optional) The fabric location of runbook or script. Possible values are Primary and Recovery. It must not be specified when type is ManualActionDetails.
          runbook_id                = try(post_action.value.runbook_id, null)
          manual_action_instruction = try(post_action.value.manual_action_instruction, null)
          script_path               = try(post_action.value.script_path, null)
        }
      }
    }
  }

  dynamic "azure_to_azure_settings" {
    for_each = try(var.settings.azure_to_azure_settings, null) != null ? [var.settings.azure_to_azure_settings] : []
    content {
      primary_zone  = azure_to_azure_settings.value.primary_zone
      recovery_zone = azure_to_azure_settings.value.recovery_zone
    }
  }
}
