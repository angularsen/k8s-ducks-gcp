provider "google" {
    credentials = "${file("secrets/account.json")}"
    project     = "k8s-ducks"
    region      = "europe-north1"
}

provider "google-beta" {
    credentials = "${file("secrets/account.json")}"
    project     = "k8s-ducks"
    region      = "europe-north1"
}