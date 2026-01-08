terraform {
  backend "azurerm" {
    resource_group_name  = "cicdtest"         # A backend RG-je
    storage_account_name = "statestorageacc"  # A backend Storage Account neve
    container_name       = "tfstate"          # A container neve
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "4859d41e-e030-4342-af6b-f795b3c40b36"
}

