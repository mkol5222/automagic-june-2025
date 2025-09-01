resource "azurerm_public_ip" "public_ip" {
  name                = "${var.vm_name}-pip"
  location            = azurerm_resource_group.linux.location
  resource_group_name = azurerm_resource_group.linux.name
  allocation_method   = "Static"


  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.vm_name}-ngs"
  location            = azurerm_resource_group.linux.location
  resource_group_name = azurerm_resource_group.linux.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

    security_rule {
    name                       = "HTTP"
    priority                   = 1010
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

resource "azurerm_network_interface" "nic" {

  name                = "${var.vm_name}-nic"
  location            = azurerm_resource_group.linux.location
  resource_group_name = azurerm_resource_group.linux.name

  ip_configuration {
    name                          = "myNicConfiguration"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }

}

resource "azurerm_network_interface_security_group_association" "association" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

