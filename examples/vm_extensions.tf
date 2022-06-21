## Extensions have moved! We now have them inside the module directly to improve graph processing
## The moved instructions are supported Terraform 1.1 and are to be removed after a couple of release.
moved {
  from = module.microsoft_enterprise_cloud_monitoring
  to   = module.example.module.microsoft_enterprise_cloud_monitoring
}
moved {
  from = module.vm_extension_diagnostics
  to   = module.example.module.vm_extension_diagnostics
}
moved {
  from = module.vm_extension_microsoft_azure_domainjoin
  to   = module.example.module.vm_extension_microsoft_azure_domainjoin
}
moved {
  from = module.vm_extension_session_host_dscextension
  to   = module.example.module.vm_extension_session_host_dscextension
}
moved {
  from = module.vm_extension_custom_scriptextension
  to   = module.example.module.vm_extension_custom_scriptextension
}
