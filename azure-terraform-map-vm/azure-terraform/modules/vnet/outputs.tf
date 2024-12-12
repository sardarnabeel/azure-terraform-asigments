output "vnet_ids" {
  description = "Map of VNet IDs"
  value = {
    for k, v in azurerm_virtual_network.vnet : k => v.id
  }
}

output "subnet_ids" {
  description = "Map of Subnet IDs by subnet name"
  value = {
    for key, subnet in azurerm_subnet.subnet : subnet.name => subnet.id
  }
}

