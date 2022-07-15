# Stashing for later use as not implemented in azurerm 2.88.1

global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  rg1 = {
    name = "sentinal"
  }
}

log_analytics = {
  law1 = {
    name               = "sentinal-automation-rule"
    resource_group_key = "rg1"
    solutions_maps = {
      SecurityInsights = {
        "publisher" = "Microsoft"
        "product"   = "OMSGallery/SecurityInsights"
      }
    }
  }
}

sentinel_watchlists = {
  wl1 = {
    name = "example-watchlist"
    log_analytics_workspace = {
      #lz_key = ""
      key = "law1"
    }
    display_name = "wl1"
    description  = "test_description"
    labels       = ["test1", "test2"]
    # item_search_key = "Key"
  }
}

sentinel_watchlist_items = {
  wi1 = {
    sentinel_watchlist = {
      #lz_key = ""
      key = "wl1"
    }
    properties = {
      k1 = "v1"
      k2 = "v2"
    }
  }
}
