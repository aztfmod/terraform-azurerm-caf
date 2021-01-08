# Azure Application Insights

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_app_insights" {
  source  = "aztfmod/caf/azurerm//modules/app_insights"
  version = "4.21.2"
  # insert the 9 required variables here
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
| azurecaf | n/a |
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| application\_type | (Required) Specifies the type of Application Insights to create. Valid values are ios for iOS, java for Java web, MobileCenter for App Center, Node.JS for Node.js, other for General, phone for Windows Phone, store for Windows Store and web for ASP.NET. Please note these values are case sensitive; unmatched values are treated as ASP.NET by Azure. Changing this forces a new resource to be created. | `string` | `"other"` | no |
| base\_tags | Base tags for the resource to be inherited from the resource group. | `map` | n/a | yes |
| daily\_data\_cap\_in\_gb | (Optional) Specifies the Application Insights component daily data volume cap in GB. | `number` | `null` | no |
| daily\_data\_cap\_notifications\_disabled | (Optional) Specifies if a notification email will be send when the daily data volume cap is met. (set to false to enable) | `bool` | `true` | no |
| disable\_ip\_masking | (Optional) By default the real client ip is masked as 0.0.0.0 in the logs. Use this argument to disable masking and log the real client ip. Defaults to false. | `bool` | `false` | no |
| global\_settings | Global settings object when the resource is deploye in landing zones context. | `any` | `null` | no |
| location | (Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| name | (Required) Specifies the name of the Application Insights component. Changing this forces a new resource to be created. | `string` | n/a | yes |
| prefix | You can use a prefix to add to the list of resource groups you want to create | `string` | n/a | yes |
| resource\_group\_name | (Required) The name of the resource group where to create the resource. | `string` | n/a | yes |
| retention\_in\_days | (Optional) Specifies the retention period in days. Possible values are 30, 60, 90, 120, 180, 270, 365, 550 or 730. Defaults to 90. | `number` | `90` | no |
| sampling\_percentage | (Optional) Specifies the percentage of the data produced by the monitored application that is sampled for Application Insights telemetry. | `number` | `null` | no |
| tags | (Required) Map of tags to be applied to the resource | `map` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| app\_id | The App ID associated with this Application Insights component. |
| connection\_string | The Connection String for this Application Insights component. (Sensitive) |
| id | The ID of the Application Insights component. |
| instrumentation\_key | The Instrumentation Key for this Application Insights component. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->