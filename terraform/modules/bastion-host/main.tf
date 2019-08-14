resource "google_compute_instance" "bastion-host" {
  name         = "${var.name}"
  machine_type = "n1-standard-1"
  zone         = "${var.zone}"

  tags = ["ssh", "bastion-host"]

  boot_disk {
    initialize_params {
      image = "centos-7"
    }
  }

  // Local SSD disk
  scratch_disk {
  }

  network_interface {
    subnetwork = "${var.subnetwork}"

    access_config {
      // Ephemeral IP
    }
  }

  service_account {
    email  = "${var.service_account}"
    scopes = ["cloud-platform"]
  }

  provisioner "remote-exec" {
    connection {
      host        = "${google_compute_instance.bastion-host.network_interface.0.access_config.0.nat_ip}"
      user        = ""
      type        = "ssh"
      private_key = "${file(var.ssh_key)}"
    }

    inline = [
      "sudo yum install -y kubectl",
      "gcloud config set compute/zone ${var.zone}",
      "gcloud container clusters get-credentials ${var.gke_cluster_name}"
    ]
  }
}
