output "vm_ids" {
  description = "A map of Virtual Machine IDs"
  value = {
    for vm_key, vm in azurerm_linux_virtual_machine.vm :
    vm_key => vm.id
  }
}


output "nic_ids" {
  description = "The NIC IDs for each VM"
  value       = { for k, v in azurerm_network_interface.vm_nic : k => v.id }
}
#1. Capture the Private IP Address in azurerm_network_interface
output "vm_private_ips" {
  value = { for vm, nic in azurerm_network_interface.vm_nic : vm => nic.ip_configuration[0].private_ip_address }
  description = "Private IPs of all VMs"
}
# #4. Optional: Retrieve the Private IP for a Specific VM
# output "vm2_private_ip" {
#   value = azurerm_network_interface.vm_nic["vm2"].ip_configuration[0].private_ip_address
#   description = "Private IP address of vm2"
# }

