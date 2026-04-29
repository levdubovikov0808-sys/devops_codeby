module "network" {
  source = "./modules/network"
  project_name = var.project_name
  region = var.region
}

module "kubernetes" {
  source       = "./modules/kubernetes"
  project_name = var.project_name
  region       = var.region
  k8s_version  = var.k8s_version
  node_count   = var.node_count
  node_flavor  = var.node_flavor
}

module "observability" {
  source       = "./modules/observability"
  project_name = var.project_name
}
