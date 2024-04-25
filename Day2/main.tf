
resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.APP_NAME}-${var.APP_ENV}-${var.RESOURCE_LOCATION}-001"
  location = var.RESOURCE_LOCATION

  tags = {
    application = var.APP_NAME,
    environment = var.APP_ENV
  }
}

resource "azurerm_virtual_network" "vn" {
  name                = "${var.APP_NAME}-${var.APP_ENV}-${var.RESOURCE_LOCATION}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.APP_NAME}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefixes     = ["10.0.2.0/24"]
}
resource "azurerm_public_ip" "az-vm-ip" {
  name                    = "${var.APP_NAME}-${var.APP_ENV}-publicip"
  location                = azurerm_resource_group.rg.location
  resource_group_name     = azurerm_resource_group.rg.name
  allocation_method       = "Static"
  idle_timeout_in_minutes = 30

  tags = {
    environment = "Dev"
  }
}

resource "azurerm_network_interface" "network_interface" {
  name                = "${var.APP_NAME}-${var.APP_ENV}-${var.RESOURCE_LOCATION}-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "${var.APP_ENV}-ipconfig"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.az-vm-ip.id
  }
}



resource "azurerm_linux_virtual_machine" "linux-dev-vm" {
  name                = "${var.APP_NAME}-${var.APP_ENV}-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.linux_vm_size
  admin_username      = var.linux_admin_username
  admin_password      = var.linux_admin_password
  disable_password_authentication = false
  

  tags = {
    environment = var.APP_ENV
  }
  network_interface_ids = [
    azurerm_network_interface.network_interface.id,
  ]

  admin_ssh_key {
    username   = var.linux_admin_username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    name = "linux-${var.APP_NAME}-${var.APP_ENV}-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    offer     = var.linux_vm_image_offer
    publisher = var.linux_vm_image_publisher
    sku       = var.rhel_8_5_sku
    version   = "latest"
  }
}
