resource "google_container_cluster" "primary" {
    initial_node_count  = "${var.cluster_instance_count}"
    name                = "${var.cluster_name}"
    location            = "${var.gcp_location}"
    node_locations      = "${var.gcp_node_locations}"

    master_auth {
        username        = "${var.linux_admin_username}"
        password        = "${var.linux_admin_password}"
    }

    # We can't create a cluster with no node pool defined, but we want to only use
    # separately managed node pools. So we create the smallest possible default
    # node pool and immediately delete it.
    remove_default_node_pool = true
    initial_node_count = 1
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
    name                = "${var.cluster_name}-node-pool"
    location            = "${var.gcp_location}"
    cluster             = "${google_container_cluster.primary.name}"
    node_count          = 1

    node_config {
        preemptible     = true
        machine_type    = "f1-micro"

        oauth_scopes    = [
            "https://www.googleapis.com/auth/compute",
            "https://www.googleapis.com/auth/devstorage.read_only",
            "https://www.googleapis.com/auth/logging.write",
            "https://www.googleapis.com/auth/monitoring",
        ]

        labels {
            this-is-for = "dev-cluster"
        }

        tags            = ["dev"]
    }
}