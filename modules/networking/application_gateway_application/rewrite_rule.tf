
resource "null_resource" "set_rewrite_rule_set" {
  depends_on = [null_resource.set_http_settings, null_resource.set_backend_pools, null_resource.set_http_listener, null_resource.set_ssl_cert, null_resource.set_root_cert]

  for_each = try(var.settings.rewrite_rule_sets, {})

  triggers = {
    rewrite_rule_set = jsonencode(each.value)
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/set_resource.sh", path.module)
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      RESOURCE                 = "REWRITERULESET"
      RG_NAME                  = var.application_gateway.resource_group_name
      APPLICATION_GATEWAY_NAME = var.application_gateway.name
      APPLICATION_GATEWAY_ID   = var.application_gateway.id
      NAME                     = each.value.name
    }
  }
}

resource "null_resource" "delete_rewrite_rule_set" {
  depends_on = [null_resource.delete_http_settings, null_resource.delete_backend_pool, null_resource.delete_http_listener, null_resource.delete_ssl_cert, null_resource.delete_root_cert]

  for_each = try(var.settings.rewrite_rule_sets, {})

  triggers = {
    rewrite_rule_set_name    = each.value.name
    resource_group_name      = var.application_gateway.resource_group_name
    application_gateway_name = var.application_gateway.name
    application_gateway_id   = var.application_gateway.id
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/delete_resource.sh", path.module)
    when        = destroy
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      RESOURCE                 = "REWRITERULESET"
      NAME                     = self.triggers.rewrite_rule_set_name
      RG_NAME                  = self.triggers.resource_group_name
      APPLICATION_GATEWAY_NAME = self.triggers.application_gateway_name
      APPLICATION_GATEWAY_ID   = self.triggers.application_gateway_id
    }
  }
}

resource "null_resource" "set_rewrite_rule" {
  depends_on = [null_resource.set_http_settings, null_resource.set_backend_pools, null_resource.set_http_listener, null_resource.set_ssl_cert, null_resource.set_root_cert, null_resource.set_rewrite_rule_set]

  for_each = try(var.settings.rewrite_rules, {})

  triggers = {
    rewrite_rule = jsonencode(each.value)
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/set_resource.sh", path.module)
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      RESOURCE                 = "REWRITERULE"
      RG_NAME                  = var.application_gateway.resource_group_name
      APPLICATION_GATEWAY_NAME = var.application_gateway.name
      APPLICATION_GATEWAY_ID   = var.application_gateway.id
      NAME                     = each.value.name
      RULE_SET_NAME            = var.settings.rewrite_rule_sets[each.value.rewrite_rule_set_key].name
      ENABLE_REROUTE           = try(each.value.enable_reroute, null)
      MODIFIED_PATH            = try(each.value.modified_path, null)
      MODIFIED_QUERY_STRING    = try(each.value.modified_query_string, null)
      REQUEST_HEADERS          = try(each.value.request_headers, null)
      RESPONSE_HEADERS         = try(each.value.response_headers, null)
      SEQUENCE                 = try(each.value.sequence, null)
    }
  }
}

resource "null_resource" "delete_rewrite_rule" {
  depends_on = [null_resource.delete_http_settings, null_resource.delete_backend_pool, null_resource.delete_http_listener, null_resource.delete_ssl_cert, null_resource.delete_root_cert, null_resource.delete_rewrite_rule_set]

  for_each = try(var.settings.rewrite_rules, {})

  triggers = {
    rewrite_rule_name        = each.value.name
    resource_group_name      = var.application_gateway.resource_group_name
    application_gateway_name = var.application_gateway.name
    application_gateway_id   = var.application_gateway.id
    rule_set_name            = var.settings.rewrite_rule_sets[each.value.rewrite_rule_set_key].name
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/delete_resource.sh", path.module)
    when        = destroy
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      RESOURCE                 = "REWRITERULE"
      NAME                     = self.triggers.rewrite_rule_name
      RG_NAME                  = self.triggers.resource_group_name
      APPLICATION_GATEWAY_NAME = self.triggers.application_gateway_name
      APPLICATION_GATEWAY_ID   = self.triggers.application_gateway_id
      RULE_SET_NAME            = self.triggers.rule_set_name
    }
  }
}

resource "null_resource" "set_rewrite_rule_condition" {
  depends_on = [null_resource.set_http_settings, null_resource.set_backend_pools, null_resource.set_http_listener, null_resource.set_ssl_cert, null_resource.set_root_cert, null_resource.set_rewrite_rule_set, null_resource.set_rewrite_rule]

  for_each = try(var.settings.rewrite_rule_conditions, {})

  triggers = {
    rewrite_rule_condition = jsonencode(each.value)
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/set_resource.sh", path.module)
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      RESOURCE                 = "REWRITERULECONDITION"
      RG_NAME                  = var.application_gateway.resource_group_name
      APPLICATION_GATEWAY_NAME = var.application_gateway.name
      APPLICATION_GATEWAY_ID   = var.application_gateway.id
      RULE_SET_NAME            = var.settings.rewrite_rule_sets[each.value.rewrite_rule_set_key].name
      RULE_NAME                = var.settings.rewrite_rules[each.value.rewrite_rule_key].name
      VARIABLE                 = each.value.variable
      IGNORE_CASE              = try(each.value.ignore_case, null)
      NEGATE                   = try(each.value.negate, null)
      PATTERN                  = try(each.value.pattern, null)
    }
  }
}

resource "null_resource" "delete_rewrite_rule_condition" {
  depends_on = [null_resource.delete_http_settings, null_resource.delete_backend_pool, null_resource.delete_http_listener, null_resource.delete_ssl_cert, null_resource.delete_root_cert, null_resource.delete_rewrite_rule_set, null_resource.delete_rewrite_rule]

  for_each = try(var.settings.rewrite_rule_conditions, {})

  triggers = {
    variable                 = each.value.variable
    resource_group_name      = var.application_gateway.resource_group_name
    application_gateway_name = var.application_gateway.name
    application_gateway_id   = var.application_gateway.id
    rule_set_name            = var.settings.rewrite_rule_sets[each.value.rewrite_rule_set_key].name
    rule_name                = var.settings.rewrite_rules[each.value.rewrite_rule_key].name
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/delete_resource.sh", path.module)
    when        = destroy
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      RESOURCE                 = "REWRITERULECONDITION"
      VARIABLE                 = self.triggers.variable
      RG_NAME                  = self.triggers.resource_group_name
      APPLICATION_GATEWAY_NAME = self.triggers.application_gateway_name
      APPLICATION_GATEWAY_ID   = self.triggers.application_gateway_id
      RULE_SET_NAME            = self.triggers.rule_set_name
      RULE_NAME                = self.triggers.rule_name
    }
  }
}