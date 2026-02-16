module "rgmodule" {
  source   = "../child_module/Azurerm_Resource_Group"
  rg_child = var.rg_parent

}


module "vnetmodule" {
  depends_on = [module.rgmodule]
  source     = "../child_module/Azurerm_Virtual_Network"
  vnet_child = var.vnet_parent
}

module "subnetmodule" {
  depends_on   = [module.vnetmodule]
  source       = "../child_module/Azurerm_Subnet"
  # merge subnet input with NSG id when `nsg_key` is provided in terraform.tfvars
  subnet_child = { for k, v in var.subnet_parent : k => merge(v, lookup(v, "nsg_key", null) != null ? { network_security_group_id = lookup(module.nsgmodule.nsg_ids, v.nsg_key, "") } : {}) }
}


module "nsgmodule" {
  depends_on = [module.rgmodule]
  source     = "../child_module/Azurerm_netwrok_security_group"
  nsg_child  = var.nsg_parent
}


module "nicmodule" {
  depends_on = [module.subnetmodule, module.nsgmodule]
  source     = "../child_module/Azure_Network_Interface"
  nic_child  = var.nic_parent
}


module "ilbmodule" {
  depends_on = [module.nicmodule, module.subnetmodule]
  source     = "../child_module/Azurerm_Internal_Load_balancer"
  # build ILB input by merging provided ilb_parent config with resolved subnet id (from subnetmodule)
  ilb_child = { for k, v in var.ilb_parent : k => merge(v, lookup(v, "frontend_subnet_id", null) != null ? { frontend_subnet_id = v.frontend_subnet_id } : ( lookup(v, "subnet_key", null) != null ? { frontend_subnet_id = module.subnetmodule.subnet_ids[v.subnet_key] } : {}) ) }
  nic_id_map = module.nicmodule.nic_ids
  ip_configuration_name = "ipconfig1"
}


module "pipmodule" {
  depends_on = [ module.nicmodule ]
  source     = "../child_module/Azurerm_PublicIP"
  public_ip_child = var.public_ip_parent
}

module "storagemodule" {
  source = "../child_module/Azurerm_Storage_Account"
  storage_account_child = var.storage_account_parent
}

module "linuxvmmodule" {
  depends_on = [module.nicmodule]
  source     = "../child_module/Azurerm_Linux_Vm"
  # merge each VM input with the corresponding NIC id (key must match); if no exact match, use the first available NIC id
  linux_vm_child = { for k, v in var.myvmparent : k => merge(v, { network_interface_ids = [ lookup(module.nicmodule.nic_ids, k, length(keys(module.nicmodule.nic_ids)) > 0 ? values(module.nicmodule.nic_ids)[0] : "") ] }) }

  }


module "storagecontainermodule" {
  depends_on = [ module.storagemodule ]
source = "../child_module/Azurerm_storage_container"
  container_child = { for k, v in var.container_parent : k => merge(v, { storage_account_id = lookup(module.storagemodule.storage_account_ids, v.storage_account_id, v.storage_account_id), storage_account_name = lookup(module.storagemodule.storage_account_names, v.storage_account_id, v.storage_account_id) }) }
}



