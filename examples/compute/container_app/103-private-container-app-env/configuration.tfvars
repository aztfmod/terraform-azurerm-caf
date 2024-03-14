global_settings = {
  default_region = "region1"
  regions = {
    region1 = "canadacentral"
  }
}

resource_groups = {
  rg1 = {
    name   = "container-app-001"
    region = "region1"
  }
}

diagnostic_log_analytics = {
  central_logs_region1 = {
    region             = "region1"
    name               = "logs"
    resource_group_key = "rg1"
  }
}

vnets = {
  cae_re1 = {
    resource_group_key = "rg1"
    region             = "region1"
    vnet = {
      name          = "container-app-network"
      address_space = ["100.64.0.0/20"]
    }
    specialsubnets = {}
    subnets = {
      cae1 = {
        name    = "container-app-snet"
        cidr    = ["100.64.0.0/21"]
        nsg_key = "empty_nsg"
      }
    }

  }
}

network_security_group_definition = {
  # This entry is applied to all subnets with no NSG defined
  empty_nsg = {}
}

managed_identities = {
  msi1 = {
    name               = "ca-identity-001"
    resource_group_key = "rg1"
  }
}

storage_accounts = {
  sa1 = {
    name                     = "sa1caes001"
    resource_group_key       = "rg1"
    account_kind             = "FileStorage"
    account_tier             = "Premium"
    account_replication_type = "LRS"
    min_tls_version          = "TLS1_2"
    large_file_share_enabled = true

    file_shares = {
      fs1 = {
        name  = "fs1"
        quota = "100"
      }
    }
  }
}

container_app_environments = {
  cae1 = {
    name               = "cont-app-env-001"
    region             = "region1"
    resource_group_key = "rg1"
    log_analytics_key  = "central_logs_region1"
    vnet = {
      vnet_key   = "cae_re1"
      subnet_key = "cae1"
    }
    internal_load_balancer_enabled = true
    zone_redundancy_enabled        = true

    tags = {
      environment = "testing"
    }
  }
}

container_app_dapr_components = {
  dapr1 = {
    name                          = "dapr-component-001"
    container_app_environment_key = "cae1"
    component_type                = "state.azure.blobstorage"
    version                       = "v1"
    ignore_errors                 = false
    init_timeout                  = "1m"
    secret = [
      {
        name  = "dapr-secret1"
        value = "ccecewEWewce"
      }
    ]
    metadata = [
      {
        name  = "dapr-meta1"
        value = "ccweceww"
      },
      {
        name        = "dapr-meta2"
        secret_name = "dapr-secret1"
      }
    ]
  }
}

container_app_environment_certificates = {
  caec1 = {
    name                          = "caec-cert-001"
    container_app_environment_key = "cae1"
    certificate_blob_base64       = "LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1JSUV2QUlCQURBTkJna3Foa2lHOXcwQkFRRUZBQVNDQktZd2dnU2lBZ0VBQW9JQkFRQ3lKR2o4dXlrTUN3UmIKcEx6NU9YWTJUcy9WaWpLKzZIV2ZVZTI2QlgxMzYwOXluWkZRbXhURHJkVlR1RXcrT1czcGxEUUlMTGZQSWNlZwozYzdCYnI0VlNNazhvNWFhaTFSclZKemxKMlUvNWlDK3l1Uk0wSFV5Y09RbE01K1NiU3QyY1gvSCtScTlOdTM0CmJBVXRIM0s4NE9yb2ZnRFBPb3dsRjdrSm0yL29WaGRkeTVqOU9DWUpIUmFSZys3R1ZlSnFDaHQ0NjNkYjlBMloKYXZ5a0VTb3EvWGpxR1NGTEpGRjBXb0ZFSklMRE0xY3ZyZWJRNEl6NTMwSWVDTHFqRjI5NzhOcFJGMTk2TTBKOApiVVk0STNtNTk3Nk04Vk8zVWxWUk53cThkZWc1YVVkeW04eVQ2T2cxaTlEZVZLRnlaOHVWaHJKZFI1WUNKMzI1CmxqeERiQUpyQWdNQkFBRUNnZ0VBTVp3WUxNSEdkWmNmMkpHeEdzclkwOWp3NGl3Qlk4OEM2cUo3VE1HNHBrdSsKclZHYUpWTjYzZCtzT0F0c0dDd1FJdXRsN2h6ZDkyNFYxUVBRVDJnU3dZU3FuaHVFbG5kVXhDc2xJbC90UDNWTQpDellmakJERmdvMlR5NVJyelBCZ0dUVVVlOUV3bEI4VytJYkVqa05peFp6eGJsdWd5QlVxOEMyQ0YxM1ZOV05GClRSc1c1SXpiUnpaQm9Rd1U0aFQ5NWJGNkxkcHp1NWRFNjY5eEZrSmh6cWVlczNqWkVLK3BvVWV0VjFneEt1TkUKUW5MN1ZPQXdraFp5UjR4cXg2cVZPaEw0QlFSempJSDUzRlJBRWFiWmZhUVRDMm0wVlNzMndlOFJhaFFTOEFrYwptNitpWkJHcVFhQ0lLVDBQSkhNbi9GaFVQTHNwZEU3b1Z5WXc4UU5OS1FLQmdRRE9Wa0hVU25oOFhCR2VwMExXClVtdmtRQ1VvcXMzZnhKMmh3VjMxZ2IwZEt4OUZPU25qMkRlUHFic2hsVWdBMW4vcnFXQ05aNnhNazh3OWh2dDkKSXlkWWg3TWVjK3l4VTYxaElET1ZkcUxFS2d1UWZ5akZ1NzNUYTNIRDlKOEZvazBmWmFINWxMd3k1NHUvVjBWSApmaUpzZ3RTOTZVZnRuUC93ZnRWZUlpdFFEd0tCZ1FEZEJPVkt5S2xyUWFuWVptVGRTVUxFaE1TQnRDdm50ZTM4ClgvM3NwRms5WE45Z0NzUnpoekozQkM3NzA4SUlOdVZJV1kzRzBoYUNRNDMweURna29SNm8yWTlNSU1TNkQwWUQKREVXaXM5c2pEQlFQNEMrMXc1ZVlKRWFWUllaeE1vMXBsZitrNk5DK3ZaSXYxQXlPQTQ1S0twUDhZSmdmNk5GQQpNY2h0UVRkTDVRS0JnSDlOZEp2M3ZsSnJzMnRCSXRsOFRKaXNnc0NPY1NwbjhpRkVYaVlFZjVzcGFjZVp0eUNkCjI5bkZESEZ4MnRTNWduN3hKMkxXM2RUNU12K2E4anFJbjlQZEZVUHFuZFBpSG94WUE3dHBVSTdhcWZ2aW1GTTIKdTYxZkV2ZWxTeDk4dlR4cnhmMW9LSnozZ3A3d3h3dU81TW95QmZPTnBCVVQwa3ljMUNPWnpVTTlBb0dBWjZ6aQpPZUJDeUpNMnJ0SHBRbndaRzhJRHc2dldaSXpNby9RTFVyUU5RR0dPVHFqK1dncnpPeXoxTlIreUJ0UnBYVFRVCjhveWVEbUROK0NMcll4TkpKSDlaWHFhSVlaYkVpcTE1Qk1kRlpmMUdjK1AvdlUyUWtNZURiSVgrZUo3MEFyRmcKQitWRjloTkt2YkRFYXVGMEg0bzFmTTk2ekkwVGl2OVBPeUM2WlprQ2dZQVdkUjNxYVJrUzJuVVNiT2hrS2s2ZgoyK0xkRWMwcmFuSE5EYW9kMzZTbDYrRm5RbVNSWC90QTB3UUFnZnhoRERlWENGR3lnV1EvKytTUmt3a0g1Nnp2CjYxb0lCWmlEdkd5YkYrb251dDRJRnlTU0NQM3BiQ2ExeHpVNVNUaVgzMTdOVUVkUG00M3hOVS96eVA3MFlid1UKc01rd1AvUXFmaVcyTVhVcTRoaEU3QT09Ci0tLS0tRU5EIFBSSVZBVEUgS0VZLS0tLS0KLS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURiekNDQWxlZ0F3SUJBZ0lRUFMwL2ZLTlhWWUpoWW5YVm9zU0wxREFOQmdrcWhraUc5dzBCQVFzRkFEQVcKTVJRd0VnWURWUVFERXd0bGVHRnRjR3hsTG1OdmJUQWVGdzB5TWpBM01qWXhORFUxTlROYUZ3MHpNakEzTWpNeApORFUxTlROYU1GY3hDekFKQmdOVkJBWVRBbFZUTVJ3d0dnWURWUVFLRXhORmVHRnRjR3hsSUZObGJHWWdVMmxuCmJtVmtNUlF3RWdZRFZRUUxFd3RsZUdGdGNHeGxMbU52YlRFVU1CSUdBMVVFQXhNTFpYaGhiWEJzWlM1amIyMHcKZ2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLQW9JQkFRQ3lKR2o4dXlrTUN3UmJwTHo1T1hZMgpUcy9WaWpLKzZIV2ZVZTI2QlgxMzYwOXluWkZRbXhURHJkVlR1RXcrT1czcGxEUUlMTGZQSWNlZzNjN0JicjRWClNNazhvNWFhaTFSclZKemxKMlUvNWlDK3l1Uk0wSFV5Y09RbE01K1NiU3QyY1gvSCtScTlOdTM0YkFVdEgzSzgKNE9yb2ZnRFBPb3dsRjdrSm0yL29WaGRkeTVqOU9DWUpIUmFSZys3R1ZlSnFDaHQ0NjNkYjlBMlphdnlrRVNvcQovWGpxR1NGTEpGRjBXb0ZFSklMRE0xY3ZyZWJRNEl6NTMwSWVDTHFqRjI5NzhOcFJGMTk2TTBKOGJVWTRJM201Cjk3Nk04Vk8zVWxWUk53cThkZWc1YVVkeW04eVQ2T2cxaTlEZVZLRnlaOHVWaHJKZFI1WUNKMzI1bGp4RGJBSnIKQWdNQkFBR2plREIyTUE0R0ExVWREd0VCL3dRRUF3SUZvREFkQmdOVkhTVUVGakFVQmdnckJnRUZCUWNEQVFZSQpLd1lCQlFVSEF3SXdEQVlEVlIwVEFRSC9CQUl3QURBZkJnTlZIU01FR0RBV2dCVEFxYWFkZ1diNGFLc1IyS2VFCmZlQ1NBNEFqZlRBV0JnTlZIUkVFRHpBTmdndGxlR0Z0Y0d4bExtTnZiVEFOQmdrcWhraUc5dzBCQVFzRkFBT0MKQVFFQVhSRkVraTVTbXJkL2p5OGk5TzBhYmpDSWczd0NpQkxaU0V0aE1MZ3hIbjZwUDN4K0xialZ3OGdOb0FQNApUNndaTmdhWkYvSlF0c09UQ2Ird0thenc0b1IvOE5xajFIWjdWT0hERU5yWVdPaG5nSjl0MFh1TC90OU1UaXBXCnRkR21wT0xVMURReU9VRFlJbWhhY05IVUxaeHd4TFdVU1F4Y25SSUJRTjdjemZ1NjFmcFp0dWFhMkhTYzIrVDkKNjFKeG5hRERlWldzQXQ1MXp3bjk0M3h2V3BFQjB1dGVKQnVIVWNUbUxGalVoaVV4RmxSM3Q0dWI0bDdPR1pmWgoxUG90OE4wM2lmNUN1N2lldGRhSUczYW4wNWZKYnJFTXVBaXFEdWtjb3FnNmxVRzlyZVdHQnRKUlBIMHMwRHNxCkVXNFM5Tzc2eHhUTWxLai9Tdlh2WHVkVUVBPT0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="
    certificate_password          = ""
  }
}

container_app_environment_storages = {
  caes1 = {
    name                          = "caes-storage-001"
    container_app_environment_key = "cae1"
    storage_account = {
      account_key = "sa1"
    }
    share_name  = "fs1"
    access_mode = "ReadWrite"
  }
}

container_apps = {
  ca1 = {
    name                          = "nginx-app"
    container_app_environment_key = "cae1"
    resource_group_key            = "rg1"

    revision_mode = "Single"
    template = {
      container = {
        cont1 = {
          name   = "nginx"
          image  = "nginx:latest"
          cpu    = 0.5
          memory = "1Gi"
          liveness_probe = {
            port      = 80
            transport = "HTTP"
          }
          readiness_probe = {
            port      = 80
            transport = "HTTP"
          }
          startup_probe = {
            port      = 80
            transport = "HTTP"
          }
          env = [
            {
              name  = "VAR1"
              value = "value1"
            },
            {
              name  = "VAR2"
              value = 2
            },
            {
              name        = "SECRET_VAR"
              secret_name = "secret1"
            }
          ]
          volume_mounts = {
            vol1 = {
              name = "vol1"
              path = "/mnt/vol1"
            }
          }
        }
      }

      min_replicas = 1
      max_replicas = 3

      http_scale_rule = {
        rule1 = {
          name                = "azure-http-rule"
          concurrent_requests = 50
        }
      }

      volume = {
        vol1 = {
          name         = "vol1"
          storage_name = "caes-storage-001"
          storage_type = "AzureFile"
        }
      }
    }
    ingress = {
      external_enabled           = false
      target_port                = 80
      transport                  = "http"
      allow_insecure_connections = true
      traffic_weight = {
        blue = {
          label           = "blue"
          latest_revision = false
          revision_suffix = "blue"
          percentage      = 70
        }
        green = {
          label           = "green"
          latest_revision = true
          revision_suffix = "green"
          percentage      = 30
        }
      }
      custom_domain = {
        example = {
          certificate_key = "caec1"
          name            = "example.com"
        }
      }
    }
    secret = [
      {
        name  = "secret1"
        value = "djwHJcwjh"
      },
      {
        name  = "secret2"
        value = "cdjGHjew"
      }
    ]
    identity = {
      type = "UserAssigned" // Possible options are 'SystemAssigned, UserAssigned' 'SystemAssigned' or 'UserAssigned'
      managed_identity_keys = [
        "msi1"
      ]
    }
    # registry = {
    #   server = "testacr.azurecr.io"
    #   identity = {
    #     key = "msi1"
    #   }
    # }
  },
  ca2 = {
    name                          = "dapr-app"
    container_app_environment_key = "cae1"
    resource_group_key            = "rg1"

    revision_mode = "Single"
    dapr = {
      app_id   = "nodeapp"
      app_port = 3000
    }
    template = {
      container = {
        cont1 = {
          name   = "nodeapp"
          image  = "daprio/daprd:edge"
          cpu    = 0.5
          memory = "1Gi"
        }
      }
      min_replicas = 1
      max_replicas = 1
    }
  }
}
