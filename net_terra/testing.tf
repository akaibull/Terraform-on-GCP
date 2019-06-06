resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"
  zone         = "us-west1-a"

  tags = ["tinc"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1604-lts"
    }
  }

  scratch_disk {
	} //local ssd which is ephemeral(not persistent)

  network_interface {
    network       = "${google_compute_network.vpc-net.self_link}"
    access_config = {}                                            //for creating a public ip
  }

  metadata {
    sshkeys = "ubuntu:${file(var.ssh_public)}"
  }
}

resource "google_compute_network" "vpc-net" {
  name                    = "terra-net"
  auto_create_subnetworks = "true"
}

output "instance_id" {
  value = "${google_compute_instance.vm_instance.self_link}" //self_link is terraform interpolation for getting the data from the resource
}
