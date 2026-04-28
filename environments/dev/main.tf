locals {                               // Using local variable because tags are common
  common_tags = {
    "ManagedBy" =  "Terraform"
    "Owner" = "TodoAppTeam"
    "Environment" = "dev"
  }
}

module "rg" {
  source                  = "../../modules/azurerm_resource_group"
  rg_name = var.rg_name
  location = var.rg_location
  rg_tags = local.common_tags // {
  #   "ManagedBy" =  "Terraform"
  #   "Owner" = "TodoAppTeam"
  #   "Environment" = "dev"
  # }
}

module "acr" {
  depends_on = [ module.rg ]
  source = "../../modules/azurerm_container_registry"
  acr_name = "acrdevtodoapp"
  rg_name = "rg-dev-todoapp"
  location = "centralindia"
  tags = local.common_tags  // {
  #   "ManagedBy" =  "Terraform"
  #   "Owner" = "TodoAppTeam"
  #   "Environment" = "dev"
  # }
}

module "sql_server" {
  depends_on = [ module.rg ]
source = "../../modules/azurerm_sql_sever"
sql_server_name = "sql-dev-todoapp"
rg_name = "rg-dev-todoapp"
location = "centralindia"
admin_username = "devopsadmin"
admin_password = "P@ssw0rd@123"
tags = local.common_tags  // {
  #   "ManagedBy" =  "Terraform"
  #   "Owner" = "TodoAppTeam"
  #   "Environment" = "dev"
  # }

}

module "sql_db" {
  depends_on = [ module.sql_server ]
  source = "../../modules/azurerm_sql_database"
  sql_db_name = "sqldb-dev-todoapp"
  sql_server_id = module.sql_server.server_id
  max_size_gb = "2"
  tags = local.common_tags  // {
  #   "ManagedBy" =  "Terraform"
  #   "Owner" = "TodoAppTeam"
  #   "Environment" = "dev"
  # }
}

module "aks" {
  depends_on = [ module.rg ]
  source = "../../modules/azurerm_kubernetes_cluster"
  aks_name = "aks-dev-todoapp"
  location = "centralindia"
  rg_name = "rg-dev-todoapp"
  dns_prefix = "aks-dev-todoapp"
  tags = local.common_tags  // {
  #   "ManagedBy" =  "Terraform"
  #   "Owner" = "TodoAppTeam"
  #   "Environment" = "dev"
  # }
}

# module "storage_account" {
#   depends_on               = [module.resource_group] // This is "meta argument"
#   source                   = "../../modules/storage_account"
#   resource_group_name      = var.rg_name // using same variable as above for resource group
#   storage_account_name     = var.sa_name
#   storage_account_location = var.sa_location
# }