resource "google_container_cluster" "gcp_kubernetes" {
    initial_node_count  = "${var.cluster_instance_count}"
    name                = "${var.cluster_name}"
    location            = "${var.gcp_location}"
    node_locations      = "${var.gcp_node_locations}"

    master_auth {
        username        = "${var.linux_admin_username}"
        password        = "${var.linux_admin_password}"
    }

    node_config {
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