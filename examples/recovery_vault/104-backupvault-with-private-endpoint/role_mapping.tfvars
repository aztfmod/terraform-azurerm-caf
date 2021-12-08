role_mapping = {
  built_in_role_mapping = {
    resource_groups = {
      primary = {
        "Contributor" = {
          #lz_key = "" if the resource group is deployed in a remote landing zone
          "recovery_vaults" = {
            keys = ["asr1"]
          }
        }
      }
      secondary = {
        "Contributor" = {
          #lz_key = "" if the resource group is deployed in a remote landing zone
          "recovery_vaults" = {
            keys = ["asr1"]
          }
        }
      }
      dnszones = {
        "Contributor" = {
          #lz_key = "" if the resource group is deployed in a remote landing zone
          "recovery_vaults" = {
            keys = ["asr1"]
          }
        }
      }
    }
  }
}