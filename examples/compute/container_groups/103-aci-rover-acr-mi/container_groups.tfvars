container_groups = {
  rover_level0 = {
    name               = "ci-rover-level0"
    region             = "region1"
    resource_group_key = "rg1"
    ip_address_type    = "Public"

    os_type        = "Linux"
    restart_policy = "Always" // Possible values are 'Always'(default) 'Never' 'OnFailure'

    containers = {
      rover = {
        name   = "aztfmod-rover"
        image  = "acrtest.azurecr.io/rover-agent:1.5.3-2307.2007-azdo"
        cpu    = "1"
        memory = "1"

        ports = {
          22 = {
            port     = 22
            protocol = "TCP"
          }
        }

        environment_variables = {
          ARM_USE_MSI               = true
          AGENT_KEYVAULT_SECRET     = "azdo-pat-agent" #secret name for the pat
          VSTS_AGENT_INPUT_AGENT    = "rover-agent"    #non random agent name
          VSTS_AGENT_INPUT_POOL     = "level0"
          VSTS_AGENT_INPUT_URL      = "https://myorg.visualstudio.com/"
          VSTS_AGENT_INPUT_AUTH     = "pat"
          VSTS_AGENT_INPUT_RUN_ARGS = "--once"
        }

        environment_variables_from_resources = {
          AGENT_KEYVAULT_NAME = {
            output_key    = "keyvaults"
            resource_key  = "level0"
            attribute_key = "name"
          }
          MSI_ID = {
            output_key    = "managed_identities"
            resource_key  = "level0"
            attribute_key = "id"
          }
        }
      }
    } //containers

    identity = {
      type = "UserAssigned"
      managed_identity_keys = [
        "level0",
      ]
    }

    image_registry_credentials = {
      acr1 = { # To be able to pull container from private repo
        user_assigned_identity_key = "level0"
        server                     = "acrtest.azurecr.io"
      }
    }
  }
}