variable "vm_config" {
  description = "A map of VM configurations"
  type = map(object({
    vm_name         = string
    vm_size         = string
    admin_username  = string
    # ssh_public_key  = string
    image_publisher = string
    image_offer     = string
    image_sku       = string
    # user_data       = string
    nsg_name        = string
    subnet_name     = string
    ssh_public_key  = string
  }))
}
variable "location" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "subnet_ids" {
  description = "Map of Subnet IDs by subnet name"
  type        = map(string)
}

variable "nsg_ids" {
  description = "Map of NSG IDs"
  type        = map(string)
}

# variable "user_data" {
#   description = "Custom data for VM initialization"
#   type        = string
#   default     = null
# }