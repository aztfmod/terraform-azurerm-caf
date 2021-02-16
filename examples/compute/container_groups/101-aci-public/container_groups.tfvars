container_groups = {
  # aci_group1 = {
  #   name               = "example"
  #   region             = "region1"
  #   resource_group_key = "rg1"
  #   ip_address_type    = "Public"
  #   dns_name_label     = "caf-ci"
  #   os_type            = "Linux"
  #   restart_policy     = "Never" // Possible values are 'Always'(default) 'Never' 'OnFailure'

  #   containers = {
  #     helloworld = {
  #       name   = "hello-world"
  #       image  = "microsoft/aci-helloworld:latest"
  #       cpu    = "0.5"
  #       memory = "1.5"

  #       ports = {
  #         80 = {
  #           port     = 80
  #           protocol = "TCP"
  #         }
  #       }
  #     } //helloworld

  #     sidecar = {
  #       name   = "sidecar"
  #       image  = "microsoft/aci-tutorial-sidecar"
  #       cpu    = "0.5"
  #       memory = "1.5"

  #       environment_variables = {
  #         runtime = "dotnetcore"
  #         version = "3.1"
  #       }
  #     } //sidecar
  #   }   //containers

  #   tags = {
  #     environment = "testing"
  #   }

  #   identity = {
  #     type = "UserAssigned" // Possible options are 'SystemAssigned, UserAssigned' 'SystemAssigned' or 'UserAssigned'
  #     managed_identity_keys = [
  #       "aci_group1"
  #     ]
  #   } // identity

  # } //aci_group1

  aci_rover = {
    lz_key             = "local"
    name               = "rover"
    region             = "region1"
    resource_group_key = "rg1"
    ip_address_type    = "Public"
    os_type            = "Linux"
    restart_policy     = "Never" // Possible values are 'Always'(default) 'Never' 'OnFailure'

    containers = {
      nginx = {
        name   = "nginx"
        image  = "nginx"
        cpu    = "0.5"
        memory = "1.5"

        ports = {
          22 = {
            port     = 22
            protocol = "TCP"
          }
        }
      }

      rover_2102_0100-1 = {
        name   = "rover-2102-0100-1"
        image  = "aztfmod/roveralpha:aci"
        cpu    = "1"
        memory = "1.5"
        environment_variables = {
          VSTS_AGENT_INPUT_URL="https://dev.azure.com/caf-customers"
          VSTS_AGENT_INPUT_POOL="test"
          VSTS_AGENT_INPUT_SECRET="azdo-pat-agent"
        }
        environment_variables_from_resources = {
          VSTS_AGENT_KEYVAULT_NAME = {
            output_key    = "keyvaults"
            resource_key  = "secrets"
            attribute_key = "name"
          }
          MSI_ID = {
            output_key    = "managed_identities"
            resource_key  = "rover"
            attribute_key = "id"
          }
        }
      } //rover

      rover_2102_0100-2 = {
        name   = "rover-2102-0100-2"
        image  = "aztfmod/roveralpha:aci"
        cpu    = "1"
        memory = "1.5"
        environment_variables = {
          VSTS_AGENT_INPUT_URL="https://dev.azure.com/caf-customers"
          VSTS_AGENT_INPUT_POOL="test"
          VSTS_AGENT_INPUT_SECRET="azdo-pat-agent"
          VSTS_AGENT_INPUT_AGENT="aci_rover-2"
        }
        environment_variables_from_resources = {
          VSTS_AGENT_KEYVAULT_NAME = {
            output_key    = "keyvaults"
            resource_key  = "secrets"
            attribute_key = "name"
          }
          MSI_ID = {
            output_key    = "managed_identities"
            resource_key  = "rover"
            attribute_key = "id"
          }
        }

      } //rover

      rover_2102_0100-3 = {
        name   = "rover-2102-0100-3"
        image  = "aztfmod/roveralpha:aci"
        cpu    = "0.5"
        memory = "1.0"
        environment_variables = {
          VSTS_AGENT_INPUT_URL="https://dev.azure.com/caf-customers"
          VSTS_AGENT_INPUT_POOL="test"
          VSTS_AGENT_INPUT_AGENT="aci_rover-3"
          test="1"
        }
        secure_environment_variables = {
          VSTS_AGENT_INPUT_TOKEN="vbhv2gwmtjo6owsxeehxlm3ivuv6wqu2pubyrhlckde3su2dtsdq"
        }
      } //rover

    }   //containers

    tags = {
      environment = "testing"
    }

    identity = {
      type = "UserAssigned" // Possible options are 'SystemAssigned, UserAssigned' 'SystemAssigned' or 'UserAssigned'
      managed_identity_keys = [
        "rover"
      ]
    } // identity

  } //aci_rover

  aci_rover_tfc = {
    lz_key             = "local"
    name               = "rover-tfc"
    region             = "region1"
    resource_group_key = "rg1"
    ip_address_type    = "Public"
    os_type            = "Linux"
    restart_policy     = "Never" // Possible values are 'Always'(default) 'Never' 'OnFailure'

    containers = {
      nginx = {
        name   = "nginx"
        image  = "nginx"
        cpu    = "0.5"
        memory = "1.5"

        ports = {
          22 = {
            port     = 22
            protocol = "TCP"
          }
        }
      }

      rover_2102_0100-1 = {
        name   = "rover-2102-0100-1"
        image  = "aztfmod/roveralpha:tfc"
        cpu    = "1"
        memory = "1.5"
        environment_variables = {
          TFC_AGENT_NAME="aci-rover-tfc-01"
        }
        secure_environment_variables = {
          TFC_AGENT_TOKEN = "LXvzL8K2mL5Law.atlasv1.CZjKcyyt4kh89eBvhrYm3nLpdDysPAAbk1ZBHNP0eRypBEZPMUO5H1z5dwLOl4RhcZI"
        }
      } //rover


    }   //containers

    tags = {
      environment = "testing"
    }

    identity = {
      type = "UserAssigned" // Possible options are 'SystemAssigned, UserAssigned' 'SystemAssigned' or 'UserAssigned'
      managed_identity_keys = [
        "rover"
      ]
    } // identity

  } //rover_tfc
}
