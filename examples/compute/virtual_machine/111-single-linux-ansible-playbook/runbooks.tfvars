
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
    #
    # Full path or relative sub-path to the chdir or lz folder
    #
    runbook_path = "examples/compute/virtual_machine/111-single-linux-ansible-playbook/playbook.yml"
  }
}
