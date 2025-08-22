terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.110.0"
    }
  }

  # Backend values are passed by Jenkins during `terraform init -backend-config=...`
  backend "azurerm" {}
}

provider "azurerm" {
  features {}

  # If you export ARM_* in Jenkins env, you can omit these vars entirely.
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

