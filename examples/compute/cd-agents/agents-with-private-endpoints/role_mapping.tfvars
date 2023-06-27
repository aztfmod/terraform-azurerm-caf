role_mapping = {
  built_in_role_mapping = {
    storage_containers = {
      scripts = {
        "Storage Blob Data Contributor" = {
          logged_in = {
            keys = ["user"]
          }
        }
        "Storage Blob Data Reader" = {
          managed_identities = {
            keys = ["gitops"]
          }
        }
      }
    }
    keyvaults = {
      agents = {
        "Key Vault Secrets Officer" = {
          logged_in = {
            keys = ["user"]
          }
          managed_identities = {
            keys = ["gitops"]
          }
        }
      }
    }
    virtual_machines = {
      azdo_level0 = {
        "Virtual Machine Administrator Login" = {
          logged_in = {
            keys = ["user"]
          }
        }
      }
      tfcloud = {
        "Virtual Machine Administrator Login" = {
          logged_in = {
            keys = ["user"]
          }
        }
      }
    }
  }
}

# role_mapping = {
#   built_in_role_mapping = {
#     keyvaults = {
#       agents = {
#         "Key Vault Secrets Officer" = {
#           azuread_groups = {
#             keys = [
#               "caf_platform_maintainers",
#               "level0"
#             ]

#           }

#         }
#         "Key Vault Secrets User" = {
#           azuread_groups = {
#             keys = [
#               "caf_platform_maintainers",
#               "identity"
#             ]

#           }

#         }

#       }
#       level1 = {
#         "Key Vault Secrets Officer" = {
#           azuread_groups = {
#             keys = [
#               "caf_platform_maintainers",
#               "level0"
#             ]

#           }

#         }
#         "Key Vault Secrets User" = {
#           azuread_groups = {
#             keys = [
#               "alz",
#               "caf_platform_contributors",
#               "identity",
#               "management",
#               "security",
#               "subscription_creation_landingzones",
#               "subscription_creation_platform"
#             ]

#           }

#         }

#       }
#       level2 = {
#         "Key Vault Secrets Officer" = {
#           azuread_groups = {
#             keys = [
#               "caf_platform_maintainers",
#               "level0",
#               "subscription_creation_landingzones"
#             ]

#           }

#         }
#         "Key Vault Secrets User" = {
#           azuread_groups = {
#             keys = [
#               "alz",
#               "caf_platform_contributors",
#               "connectivity",
#               "identity",
#               "management",
#               "security",
#               "subscription_creation_platform"
#             ]

#           }

#         }

#       }

#     }
#     management_group = {
#       root = {
#         Contributor = {
#           azuread_groups = {
#             keys = [
#               "identity",
#               "management",
#               "security"
#             ]

#           }

#         }
#         "Management Group Contributor" = {
#           azuread_groups = {
#             keys = [
#               "alz",
#               "caf_platform_maintainers"
#             ]

#           }

#         }
#         Owner = {
#           azuread_groups = {
#             keys = [
#               "alz",
#               "caf_platform_maintainers"
#             ]

#           }

#         }
#         Reader = {
#           azuread_groups = {
#             keys = [
#               "caf_platform_contributors"
#             ]

#           }

#         }
#         "User Access Administrator" = {
#           azuread_groups = {
#             keys = [
#               "level0"
#             ]

#           }

#         }

#       }

#     }
#     resource_groups = {
#       level0 = {
#         Reader = {
#           azuread_groups = {
#             keys = [
#               "caf_platform_contributors",
#               "identity",
#               "subscription_creation_platform"
#             ]

#           }

#         }

#       }
#       level1 = {
#         Reader = {
#           azuread_groups = {
#             keys = [
#               "alz",
#               "caf_platform_contributors",
#               "connectivity",
#               "identity",
#               "management",
#               "security",
#               "subscription_creation_landingzones",
#               "subscription_creation_platform"
#             ]

#           }

#         }

#       }
#       level2 = {
#         Reader = {
#           azuread_groups = {
#             keys = [
#               "caf_platform_contributors",
#               "connectivity",
#               "identity",
#               "management",
#               "security",
#               "subscription_creation_landingzones",
#               "subscription_creation_platform"
#             ]

#           }

#         }

#       }

#     }
#     storage_accounts = {
#       level0 = {
#         "Storage Blob Data Contributor" = {
#           azuread_groups = {
#             keys = [
#               "caf_platform_maintainers",
#               "identity",
#               "level0"
#             ]

#           }

#         }
#         "Storage Blob Data Reader" = {
#           azuread_groups = {
#             keys = [
#               "alz",
#               "caf_platform_contributors",
#               "management",
#               "security",
#               "subscription_creation_platform"
#             ]

#           }

#         }

#       }
#       level1 = {
#         "Storage Blob Data Contributor" = {
#           azuread_groups = {
#             keys = [
#               "alz",
#               "caf_platform_maintainers",
#               "identity",
#               "management",
#               "security",
#               "subscription_creation_platform"
#             ]

#           }

#         }
#         "Storage Blob Data Reader" = {
#           azuread_groups = {
#             keys = [
#               "caf_platform_contributors",
#               "connectivity",
#               "level0",
#               "subscription_creation_landingzones"
#             ]

#           }

#         }

#       }
#       level2 = {
#         "Storage Blob Data Contributor" = {
#           azuread_groups = {
#             keys = [
#               "caf_platform_maintainers",
#               "connectivity",
#               "identity",
#               "level0",
#               "management",
#               "security"
#             ]

#           }

#         }
#         "Storage Blob Data Reader" = {
#           azuread_groups = {
#             keys = [
#               "caf_platform_contributors",
#               "subscription_creation_landingzones"
#             ]

#           }

#         }

#       }

#     }
#     subscriptions = {
#       logged_in_subscription = {
#         Owner = {
#           azuread_groups = {
#             keys = [
#               "caf_platform_maintainers",
#               "level0",
#               "subscription_creation_platform"
#             ]

#           }

#         }
#         Reader = {
#           azuread_groups = {
#             keys = [
#               "identity"
#             ]

#           }

#         }

#       }

#     }

#   }

# }
