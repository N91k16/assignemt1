output "ilb_ids" {
  description = "Map of internal load balancer ids keyed by input key"
  value = { for k, v in azurerm_lb.ilb : k => v.id }
}

output "backend_pool_ids" {
  description = "Map of backend pool ids keyed by input key"
  value = { for k, v in azurerm_lb_backend_address_pool.bpool : k => v.id }
}
