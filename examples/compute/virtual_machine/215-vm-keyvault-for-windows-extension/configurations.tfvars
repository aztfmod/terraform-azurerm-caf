# set default region to region1=eastus2
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus2"
  }
  inherit_tags = true
}
# all resources in this example will go into this single resource group
resource_groups = {
  rg1 = {
    name = "example-vm-keyvault-for-windows"
    tags = {
      un     = "1"
      dexx   = "xx"
      xxx    = "xxx"
      wqwq   = "wqwq"
      unq    = "1"
      dexxq  = "xx"
      xxxq   = "xxx"
      sqwqwq = "wqwq"
      qun    = "1"
      qdexx  = "xx"
      qxxx   = "xxx"
      qwqwq  = "wqwq"
      qwun   = "1"
      qwdexx = "xx"
      qwxxx  = "xxx"
      qwwqwq = "wqwq"
    }
  }
}