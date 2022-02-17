resource "netbox_cluster_type" "cluster_type" {
  name = "supernodes cluster"
}

resource "netbox_cluster_group" "cluster_group" {
  name = "supernodes cluster group"
}

resource "netbox_cluster" "cluster" {
  name = "supernodes cluster"

  cluster_group_id = netbox_cluster_group.cluster_group.id
  cluster_type_id  = netbox_cluster_type.cluster_type.id
}
