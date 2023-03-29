resource "azapi_resource" "symbolicname" {
  type      = "Microsoft.Sql/managedInstances/administrators@2022-05-01-preview"
  name      = "ActiveDirectory"
  parent_id = local.parent_id
  body = jsonencode({
    properties = {
      administratorType = "ActiveDirectory"
      login             = local.display_name
      sid               = local.object_id
      tenantId          = local.tenant_id
    }
  })
}
