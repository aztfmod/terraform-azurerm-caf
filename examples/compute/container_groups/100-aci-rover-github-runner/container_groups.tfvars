# This configuration demonstrates multiple implementations
# 1- OS Windows and Linux
# 2- instantiate container based on for_each, count or both

container_groups = {
  rover = {
    name               = "rover"
    region             = "region1"
    resource_group_key = "rg1"
    ip_address_type    = "Public"
    os_type            = "Linux"
    restart_policy     = "Never" // Possible values are 'Always'(default) 'Never' 'OnFailure'

    containers = {
      roverxpreview = {
        name   = "aztfmod-rover-preview"
        image  = "aztfmod/rover-agent:1.1.7-2203.230716-preview-github"
        cpu    = "4"
        memory = "2"

        ports = {
          22 = {
            port     = 22
            protocol = "TCP"
          }
        }

        # for demo purposes
        environment_variables = {
          URL         = "https://github.com/your_org/your_repo"
          name        = "myrover"
          ARM_USE_MSI = true
        }
        secure_environment_variables = {
          AGENT_TOKEN = "replace_with_your_token_from_gha"
        }
        environment_variables_from_resources = {
          AGENT_KEYVAULT_NAME = {
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
      }

    } //containers

    tags = {
      environment = "testing"
    }

    identity = {
      type = "UserAssigned" // Possible options are 'SystemAssigned, UserAssigned' 'SystemAssigned' or 'UserAssigned'
      managed_identity_keys = [
        "rover"
      ]
    }

  }


}
