module "resource_group" {
  source                  = "../../modules/rg"
  resource_group_name     = var.rg_name     // "rg-dev-ecomm-01"
  resource_group_location = var.rg_location // "central india"
}

module "storage_account" {
  depends_on               = [module.resource_group] // This is "meta argument"
  source                   = "../../modules/storage_account"
  resource_group_name      = var.rg_name // using same variable as above for resource group
  storage_account_name     = var.sa_name
  storage_account_location = var.sa_location
}