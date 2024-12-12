# variable "vnet_name" {
#   description = "The name of the Virtual Network"
#   type        = string
# }

# variable "address_space" {
#   description = "The address space of the Virtual Network"
#   type        = list(string)
# }



variable "vnet_test" {
  description = "Map of Virtual Network configurations"
  type = map(object({
    vnet_name      = string
    address_space  = list(string)
  }))
}


variable "subnets" {
  type = map(object({
    subnet_name       = string
    vnet_name         = string
    address_prefix    = string
    Outbound          = optional(bool, false)
    delegation        = optional(object({
      name    = string
      actions = list(string)
    }), null)
  }))
}



variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}
