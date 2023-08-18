provider "google" {
  credentials = "${file("account.json")}"
  project = "wt-gd-pdd2"
  region  = "asia-east1"
  zone    = "asia-east1-a"
}

resource "google_compute_instance" "test_vm" {
  name         = "hrs-dev-deploy-linux-asia-east1-a-1-testß"
  machine_type = "e2-standard-2"
  public_ips     = ["34.81.76.129"]

  boot_disk {
    initialize_params {
       size = 50
       image = "debian-cloud/debian-11"
    }
  }

  tags = ["cm-all-allow", "http-server", "https-server"]

  network_interface {
    # A default network is created for all GCP projects
    network       = "default"
    access_config {
    }
  }
}

