resource "selectel_managed_kubernetes_cluster_v1" "cluster" {
  name    = "${var.project_name}-k8s"
  version = var.k8s_version
}

resource "selectel_managed_kubernetes_nodegroup_v1" "nodes" {
  cluster_id = selectel_managed_kubernetes_cluster_v1.cluster.id
  name       = "${var.project_name}-nodes"
  count      = var.node_count
  flavor     = var.node_flavor
}
