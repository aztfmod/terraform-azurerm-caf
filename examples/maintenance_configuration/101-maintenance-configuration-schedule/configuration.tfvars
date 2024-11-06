global_settings = {
  default_region = "region1"
  regions = {
    region1 = "northeurope"
  }
}

resource_groups = {
  rg1 = {
    name   = "rsg_umc"
    region = "region1"
  }
}

maintenance_configuration = {
  mc_re1 = {
    name                     = "example-mc"
    region                   = "region1"
    resource_group_key       = "rg1"
    scope                    = "InGuestPatch"
    in_guest_user_patch_mode = "User"
    window = {
      start_date_time = "2023-06-08 15:04"
      duration        = "03:55"
      time_zone       = "Romance Standard Time"
      recur_every     = "2Day"
    }

    install_patches = {
      windows = {
        classifications_to_include = ["Critical", "Security"]
        # kb_numbers_to_exclude      = ["KB123456", "KB789012"]
        # kb_numbers_to_include      = ["KB345678", "KB901234"]
      }
      reboot = "IfRequired"
    }
    # tags               = {} # optional
  }
}


