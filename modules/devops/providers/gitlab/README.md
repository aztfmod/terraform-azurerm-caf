# GitLab

This submodule is part of Cloud Adoption Framework landing zones for GitLab on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "gitlab_projects" {
  source  = "aztfmod/caf/azurerm/modules/devops/providers/gitlab"
  version = "3.5.0"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| gitlabhq/gitlab | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project | The project configuration map | `map` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | The Project ID. |
| name | The Project name. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
