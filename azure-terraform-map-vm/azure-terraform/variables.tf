variable "rg-var" {
  type = object({
    location            = string
    resource_group_name = string
  })
}

#----------vm----------#


variable "vm_config" {
  description = "A map of VM configurations"
  type = map(object({
    vm_name        = string
    vm_size        = string
    admin_username = string
    # ssh_public_key  = string
    image_publisher = string
    image_offer     = string
    image_sku       = string
    # user_data       = string
    nsg_name       = string
    subnet_name    = string
    ssh_public_key = string
  }))
}

#create single rule OR create multuple rule resource using this
#-------------mysql-nsg---------#
variable "nsg_config" {
  description = "Map of NSGs with configurations"
  type        = map(any)
}



# this will work with single port rule
# variable "nsg_rules" {
#   description = "Rules to apply to NSGs"
#   type = map(object({
#     name                       = string
#     priority                   = number
#     direction                  = string
#     access                     = string
#     protocol                   = string
#     source_address_prefix      = string
#     destination_address_prefix = string
#     destination_port_range     = string
#     source_port_range          = string # Add this field
#   }))
# }

#---------vnet-----------#

variable "vnet_config" {
  description = "Map of Virtual Network configurations"
  type = map(object({
    vnet_name     = string
    address_space = list(string)
  }))
}

variable "subnet_config" {
  description = "Map of Subnet configurations"
  type = map(object({
    subnet_name    = string
    vnet_key       = string
    address_prefix = string
    Outbound       = bool
  }))
}
#------------- Load balancer -------------- #
variable "lb_name" {
  type = object({
    lb_name = string
  })
}

#-----------nat-gateway---------#
variable "nat-var" {
  type = object({
    nat_gateway_name = string
  })
}
