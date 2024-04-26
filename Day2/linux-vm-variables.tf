################################
## Azure Linux VM - Variables ##
################################

variable "linux_vm_size" {
  type        = string
  description = "Size (SKU) of the virtual machine to create"
  #default = "Standard_F2"
}

variable "linux_admin_username" {
  type        = string
  description = "Username for Virtual Machine administrator account"
  #default     = "Adminuser"
}

variable "linux_admin_password" {
  type        = string
  description = "Password for Virtual Machine administrator account"
  #default     = "Boathead@789"
}