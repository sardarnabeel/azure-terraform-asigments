resource "azurerm_virtual_network" "vnet" {
  for_each = var.vnet_test
  # name                = var.vnet_name
  name = each.value.vnet_name
  # address_space       = var.address_space
  address_space = each.value.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

#-------------without subnet delegation----------------#
# resource "azurerm_subnet" "subnet" {
#   for_each = var.subnets

#   name                            = each.value.subnet_name
#   resource_group_name             = var.resource_group_name
#   # virtual_network_name            = azurerm_virtual_network.vnet.name
#   virtual_network_name = azurerm_virtual_network.vnet[each.value.vnet_name].name
#   address_prefixes                = [each.value.address_prefix]
#   default_outbound_access_enabled = each.value.Outbound
# }

#------------subnet delegation------------#
resource "azurerm_subnet" "subnet" {
  for_each = var.subnets

  name                            = each.value.subnet_name
  resource_group_name             = var.resource_group_name
  virtual_network_name            = azurerm_virtual_network.vnet[each.value.vnet_name].name
  address_prefixes                = [each.value.address_prefix]
  default_outbound_access_enabled = each.value.Outbound

  dynamic "delegation" {
    for_each = each.value.delegation != null ? [each.value.delegation] : []
    content {
      name = delegation.value.name
      service_delegation {
        name    = "Microsoft.DBforMySQL/flexibleServers"
        actions = delegation.value.actions
      }
    }
  }
}

