provider "google" {
  credentials = file("account.json")
  project = "conductive-coil-323706"
  region  = "asia-east1"
  zone    = "asia-east1-c"
}

resource "google_compute_instance" "vm_instance" {
  name         = "bbtest09"
  machine_type = "e2-standard-4"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  tags = ["nginxtest", "http-server", "https-server"]

  network_interface {
    # A default network is created for all GCP projects
    network       = "default"
    access_config {
      // Ephemeral IP
    }
  }
}

