#===============================================
# Create firefall for bastion server
#===============================================
resource "google_compute_firewall" "firewall_vpn" {
  name    = "allow-vpn"
  project = var.parent
  # name of net
  network = "global-network-demo"

  allow {
    protocol = "tcp"
    ports    = ["443","13328"]
  }

  #   computing port!

  # allow {
  #   protocol = "udp"
  #   ports    = [""]
  # }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = [var.instance_tag]
}

#===============================================
# Create bastion server
#===============================================
resource "google_compute_instance" "vpn" {
  name           = "vpn-server"
  machine_type   = "g1-small"
  zone           = "${var.zone_instance}"
  tags           = ["${var.instance_tag}"]
  project        = var.project
  can_ip_forward = var.can_ip_forward

  # add image disk
  boot_disk {
    initialize_params {
      image = var.disk_image
    }
  }

  # add network
  network_interface {
    subnetwork = var.subnet
    access_config {
    }
  }

  metadata_startup_script = "${file("data/setup.sh")}"

  service_account {
    
    email  = var.service_account
    scopes = ["cloud-platform"]
  }
}
