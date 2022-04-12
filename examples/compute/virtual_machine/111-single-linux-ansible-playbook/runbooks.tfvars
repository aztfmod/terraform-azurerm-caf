
runbooks = {
  runbook1 = {
    type = "ansible_playbook"
    #types: remoters, ansible_playbook
    connection = {
      type = "ssh"
      endpoint = {
        # host_ip = "20.195.56.6"
        public_ip_address_key = "example_vm_pip1_rg1"
        # add support for NIC's private IP address and NIC index or NIC key
        # lz_key =
      }
      #vm_key from current and remote LZ
      user = "adminuser"

      private_key_from_vm = {
        vm_key = "example_vm1"
        # lz_key = ""
      }
      public_key_from_vm = {
        vm_key = "example_vm1"
        # lz_key = ""
      }
      # password = "toto"
      # password_from_vm = {
      #   vm_key = "example_vm1"
      # }
      timeout          = 30
      bastion_settings = {}
    }
    runbook_path = "/tf/caf/examples/compute/virtual_machine/108-single-linux-ansible-playbook/playbook.yml"
  }
}

# runbooks_associations = {
#   rba = {
#     vm_key = "virtual_machines"
#     runbook_key = "runbook1"
#   }
# }
