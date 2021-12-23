module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# virtual_desktop_application

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the Virtual Desktop Application. Changing the name forces a new resource to be created.||True|
|application_group_id| Resource ID for a Virtual Desktop Application Group to associate with the||True|
|friendly_name| Option to set a friendly name for the Virtual Desktop Application.||False|
|description| Option to set a description for the Virtual Desktop Application.||False|
|path| The file path location of the app on the Virtual Desktop OS.||True|
|command_line_argument_policy| Specifies whether this published application can be launched with command line arguments provided by the client, command line arguments specified at publish time, or no command line arguments at all. Possible values include: `DoNotAllow`, `Allow`, `Require`.||True|
|command_line_arguments| Command Line Arguments for Virtual Desktop Application.||False|
|show_in_portal| Specifies whether to show the RemoteApp program in the RD Web Access server.||False|
|icon_path| Specifies the path for an icon which will be used for this Virtual Desktop Application.||False|
|icon_index| The index of the icon you wish to use.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Virtual Desktop Application.|||



module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# virtual_desktop_application_group

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the Virtual Desktop Application Group. Changing the name forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|type| Type of Virtual Desktop Application Group.||True|
|host_pool_id| Resource ID for a Virtual Desktop Host Pool to associate with the||True|
|friendly_name| Option to set a friendly name for the Virtual Desktop Application Group.||False|
|default_desktop_display_name| Option to set the display name for the default sessionDesktop desktop when `type` is set to `Desktop`.||False|
|description| Option to set a description for the Virtual Desktop Application Group.||False|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Virtual Desktop Application Group.|||

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# virtual_desktop_host_pool

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the Virtual Desktop Host Pool. Changing the name||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|type| The type of the Virtual Desktop Host Pool. Valid options are||True|
|load_balancer_type| `BreadthFirst` load balancing distributes new user sessions across all available session hosts in the host pool.||False|
|friendly_name| A friendly name for the Virtual Desktop Host Pool.||False|
|description| A description for the Virtual Desktop Host Pool.||False|
|validate_environment| Allows you to test service changes before they are deployed to production. Defaults to `false`.  ||False|
|start_vm_on_connect| Enables or disables the Start VM on Connection Feature. Defaults to `false`.    ||False|
|custom_rdp_properties| A valid custom RDP properties string for the Virtual Desktop Host Pool, available properties can be [found in this article](https://docs.microsoft.com/en-us/windows-server/remote/remote-desktop-services/clients/rdp-files).||False|
|personal_desktop_assignment_type| `Automatic` assignment � The service will select an available host and assign it to an user.||False|
|personal_desktop_assignment_type| `Automatic` assignment � The service will select an available host and assign it to an user.||False|
|maximum_sessions_allowed|||False|
|preferred_app_group_type|||False|
|registration_info|| Block |False|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|registration_info|expiration_date| A valid `RFC3339Time` for the expiration of the token.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Virtual Desktop Host Pool.|||

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# virtual_desktop_workspace

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the Virtual Desktop Workspace. Changing the name||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|friendly_name| A friendly name for the Virtual Desktop Workspace.||False|
|description| A description for the Virtual Desktop Workspace.||False|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Virtual Desktop Workspace.|||


module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# virtual_desktop_workspace_application_group_association

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|workspace_id| The resource ID for the Virtual Desktop Workspace.||True|
|application_group_id| The resource ID for the Virtual Desktop Application Group.||True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Virtual Desktop Workspace Application Group association.|||
