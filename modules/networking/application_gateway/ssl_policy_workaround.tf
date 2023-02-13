resource "null_resource" "ssl_policy_cli" {
  provisioner "local-exec" {
    command = "az network application-gateway ssl-policy set --gateway-name ${azurerm_application_gateway.agw.name} --resource-group ${azurerm_application_gateway.agw.resource_group_name} --name AppGwSslPolicy20220101S --policy-type Predefined"
  }
}
