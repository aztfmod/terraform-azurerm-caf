# containers can be deployed using fore_each or using count
# those local variables combine them

locals {
  # Get the containers without count
  containers_foreach = {
    for key, value in var.settings.containers : key => value
    if try(value.count, null) == null
  }

  # Get the containers with count
  countainers_count = {
    for key, value in var.settings.containers : key => value
    if try(value.count, null) != null
  }

  # Expand the count countainer and add the iterator in the key and name
  countainers_count_expanded = {
    for container in
    flatten(
      [
        for key, value in local.countainers_count : [
          for number in range(value.count) :
          {
            key                          = format("%s-%s", key, number)
            iterator                     = number
            name                         = format("%s-%s", value.name, number)
            image                        = value.image
            cpu                          = value.cpu
            memory                       = value.memory
            environment_variables        = try(value.environment_variables, null)
            secure_environment_variables = try(value.secure_environment_variables, null)
            commands                     = try(value.commands, null)
            gpu                          = try(value.gpu, null)
            ports                        = try(value.ports, {})
            readiness_probe              = try(value.readiness_probe, null)
            liveness_probe               = try(value.liveness_probe, null)
            volume                       = try(value.volume, null)
          }
        ]
      ]
    ) : container.key => container
  }

  # Combine them
  combined_containers = merge(local.containers_foreach, local.countainers_count_expanded)

  #
  # resove environment variable from resource output
  #
  environment_variables_from_resources = {
    for key, value in local.environment_variables_from_resources_list : key => {
      for item in value : item.env_key => item.value
    }
  }

  environment_variables_from_resources_list = {
    for mapping in
    flatten(
      [
        for container_key, container_value in try(var.settings.containers, {}) : [
          for env_key, env_value in try(container_value.environment_variables_from_resources, {}) :
          {
            container_key = container_key
            env_key       = env_key
            value         = var.combined_resources[env_value.output_key][try(env_value.lz_key, var.client_config.landingzone_key)][env_value.resource_key][env_value.attribute_key]
          }
        ]
      ]
    ) : mapping.container_key => mapping...
  }
}