// General
variable "linux_admin_username" {
    description = "Username for Linux admin account used by Kubernetes linux agent virtual machines in the cluster."
}

variable "linux_admin_password" {
    description = "Password for the Linux admin account."
}

// GCP
variable "cluster_instance_count" {
    description = "Count of cluster instances to start."
    default     = 1
}

variable "cluster_name" {
    description = "Name of cluster."
    default     = "k8s-ducks"
}

variable "gcp_region" {
    description = "Region for cluster."
    default     = "europe-north1"
}

variable "gcp_location" {
    description = "Zone for cluster."
    default     = "europe-north1-a"
}

variable "gcp_node_locations" {
    description = "Failover zones for cluster."
    type        = "list"
    default     = ["europe-north1-b", "europe-north1-c"]
}

// GCP outputs
output "gcp_cluster_endpoint" {
    value       = "${google_container_cluster.gcp_kubernetes.endpoint}"
}

output "gcp_ssh_command" {
    value       = "ssh ${var.linux_admin_username}@${google_container_cluster.gcp_kubernetes.endpoint}"
}

output "gcp_cluster_name" {
    value       = "${google_container_cluster.gcp_kubernetes.name}"
}