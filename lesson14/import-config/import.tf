terraform {
  required_version = ">= 1.3"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 2.1.0"
    }
  }
}

provider "openstack" {
  auth_url    = "https://cloud.api.selcloud.ru/identity/v3/"
  domain_name = "294880"                     # ваш номер аккаунта
  tenant_id   = "465a79df6c58490e86483df0c6132c8f"  # UUID проекта
  user_name   = "Terraform"                   # имя сервисного пользователя
  password    = ",,RE::G[9wcy7hS~v>xu"                   # пароль
  region      = "ru-9"
}

resource "openstack_compute_instance_v2" "manual" {
  name = "manual-vm"
}
