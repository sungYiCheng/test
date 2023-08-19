provider "google" {
  credentials = "${file("account.json")}"
  project = "wt-gd-pdd2"
  region  = "asia-east1"
  zone    = "asia-east1-a"
}

resource "google_compute_firewall" "ssh" {
  name    = "hrs-test-firewall"
  network = google_compute_network.test_vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["hrs-gcpdev-ssh-test"]
}

resource "google_compute_instance" "test_vm" {
  name         = "hrs-dev-deploy-linux-asia-east1-a-1-test"
  machine_type = "e2-standard-2"
   #public_ips     = ["34.81.76.129"]

  boot_disk {
    initialize_params {
       size = 50
       image = "debian-cloud/debian-11"
    }
  }

  tags = ["cm-all-allow", "http-server", "https-server", "hrs-gcpdev-ssh-test"]

  network_interface {
    # A default network is created for all GCP projects
    network    = google_compute_network.test_vpc_network.id
    subnetwork = google_compute_subnetwork.test_subnet.id
    access_config {
        nat_ip = "34.81.76.129"   # Already Set fixed public IP, before.
    }
  }
}

resource "google_compute_network" "test_vpc_network" {
  name = "hrs-test-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "test_subnet" {
  name          = "hrs-test-subnetwork"
  ip_cidr_range = "10.55.0.0/24"
  network       = google_compute_network.test_vpc_network.id
}

