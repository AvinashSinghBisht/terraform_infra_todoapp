# az group create --name rg-terraformstate --location centralindia
# az storage account create --name terraformstate2026 --resource-group rg-terraformstate --location centralindia --sku Standard_LRS
# Manually create Container "tfstate" through Azure portal manually

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.65.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "rg-terraformstate"
    storage_account_name = "aviterraformstate2026"
    container_name = "tfstate"
    key = "dev.terraform.tfstate"     // name of statefile
  }
}

provider "azurerm" {
  features {}
  subscription_id = "66fd74fb-373d-4105-a8dd-5b12a58cf47c"
}