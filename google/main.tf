provider "google" {
  project = "example"
  region  = "europe-west3"
}

# VPC
resource "google_compute_network" "vpc" {
  name                    = "production-vpc"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "production-subnet"
  region        = "eu-central-1"
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
}

resource "google_container_cluster" "primary" {
  name     = "gke"
  location = "europe-west3"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  # remove_default_node_pool = true
  initial_node_count       = 3
  node_config {
    machine_type = "n1-standard-2"
    preemptible = "true"
  }

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
}

resource "google_sql_database_instance" "main" {
  name             = "main-instance"
  database_version = "POSTGRES_15"
  region           = "europe-west3"

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier = "db-standard-2"
  }
}