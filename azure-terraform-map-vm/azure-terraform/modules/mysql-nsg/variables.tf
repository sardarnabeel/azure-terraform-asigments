variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

#create single rule OR create multuple rule resource using
variable "nsg_config" {
  description = "Map of NSGs with configurations"
  type        = map(any)
}
# this will work with single port rule
# variable "nsg_rules" {
#   description = "Rules to apply to NSGs"
#   type        = map(object({
#     name                     = string
#     priority                 = number
#     direction                = string
#     access                   = string
#     protocol                 = string
#     source_address_prefix    = string
#     destination_address_prefix = string
#     destination_port_range   = string
#     source_port_range         = string
#   }))
# }

