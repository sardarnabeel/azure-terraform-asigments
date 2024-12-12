resource "azurerm_network_security_group" "this" {
  for_each            = var.nsg_config
  name                = each.key
  location            = var.location
  resource_group_name = var.resource_group_name
}

# # create a single rule and pass single port values this will work with single port rule
# resource "azurerm_network_security_rule" "rules" {
#   for_each                    = var.nsg_rules
#   network_security_group_name = azurerm_network_security_group.this[each.key].name
#   name                        = each.value.name
#   priority                    = each.value.priority
#   direction                   = each.value.direction
#   access                      = each.value.access
#   protocol                    = each.value.protocol
#   source_address_prefix       = each.value.source_address_prefix
#   destination_address_prefix  = each.value.destination_address_prefix
#   destination_port_range      = each.value.destination_port_range # this is only for string 
#   source_port_range           = each.value.source_port_range # this is only for string
#   resource_group_name         = var.resource_group_name
# }

#create a multiple rule and pass multiple port values this will work with multiple port rule
resource "azurerm_network_security_rule" "allow_ssh" {
  for_each                     = var.nsg_config
  name                        = "AllowSSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "22"   # Single port (SSH)
  source_port_range           = "*"
  network_security_group_name = azurerm_network_security_group.this["nsg1"].name
  resource_group_name         = var.resource_group_name
}

resource "azurerm_network_security_rule" "allow_http" {
  for_each                     = var.nsg_config
  name                        = "AllowHTTP"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "80"   # Single port (HTTP)
  source_port_range           = "*"
  network_security_group_name = azurerm_network_security_group.this["nsg1"].name
  resource_group_name         = var.resource_group_name
}

resource "azurerm_network_security_rule" "allow_mysql" {
  for_each                     = var.nsg_config
  name                        = "AllowMySQL"
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "3306" # Single port (MySQL)
  source_port_range           = "*"
  network_security_group_name = azurerm_network_security_group.this["nsg2"].name
  resource_group_name         = var.resource_group_name
}

resource "azurerm_network_security_rule" "allow_rdp" {
  for_each                     = var.nsg_config
  name                        = "AllowRDP"
  priority                    = 103
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "443" # Single port (RDP)
  source_port_range           = "*"
  network_security_group_name = azurerm_network_security_group.this["nsg2"].name
  resource_group_name         = var.resource_group_name
}

