output id {
  value     = local.os_type == "linux" ? azurerm_linux_virtual_machine.vm["linux"].id : null
  sensitive = true
}
