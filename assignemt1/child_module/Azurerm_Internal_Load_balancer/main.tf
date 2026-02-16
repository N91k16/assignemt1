locals {
  ilb_keys = keys(var.ilb_child)
}

resource "azurerm_lb" "ilb" {
  for_each = var.ilb_child

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "PrivateFrontend"
    subnet_id                     = lookup(each.value, "frontend_subnet_id", null)
    private_ip_address            = lookup(each.value, "frontend_private_ip_address", null)
    private_ip_address_allocation = lookup(each.value, "frontend_private_ip_allocation", "Dynamic")
  }
}

resource "azurerm_lb_backend_address_pool" "bpool" {
  for_each = var.ilb_child

  name              = "${each.value.name}-bpool"
  loadbalancer_id   = azurerm_lb.ilb[each.key].id
}

locals {
  # flatten ILB-port pairs into a map keyed by "<ilb_key>-<port>"
  ilb_port_pairs = flatten([for ilb_key, ilb in var.ilb_child : [for p in ilb.backend_ports : { ilb_key = ilb_key, port = p }]])
  ilb_rules_map = { for pair in local.ilb_port_pairs : "${pair.ilb_key}-${pair.port}" => pair }
}

resource "azurerm_lb_probe" "probe" {
  for_each = local.ilb_rules_map

  name            = "${each.value.ilb_key}-${each.value.port}-probe"
  loadbalancer_id = azurerm_lb.ilb[each.value.ilb_key].id
  protocol        = "Tcp"
  port            = each.value.port
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "rule" {
  for_each = local.ilb_rules_map

  name                           = "${each.value.ilb_key}-${each.value.port}-rule"
  loadbalancer_id                = azurerm_lb.ilb[each.value.ilb_key].id
  protocol                       = "Tcp"
  frontend_ip_configuration_name = azurerm_lb.ilb[each.value.ilb_key].frontend_ip_configuration[0].name
  frontend_port                  = each.value.port
  backend_port                   = each.value.port
  backend_address_pool_ids      = [azurerm_lb_backend_address_pool.bpool[each.value.ilb_key].id]
  probe_id                       = azurerm_lb_probe.probe["${each.value.ilb_key}-${each.value.port}"].id
}

# Associate provided NICs into the ILB backend pool (associates all NICs into the first ILB defined)
resource "azurerm_network_interface_backend_address_pool_association" "assoc" {
  for_each = var.nic_id_map

  network_interface_id   = each.value
  ip_configuration_name  = var.ip_configuration_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.bpool[ keys(var.ilb_child)[0] ].id
}
