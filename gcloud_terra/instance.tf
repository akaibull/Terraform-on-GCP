resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "n1-standard-1"
  zone         = "asia-south1-a"

  tags = ["tinc"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  scratch_disk {}

  network_interface {
    network = "default"

    access_config = {} //for creating a public ip(emphemeral IP)
  }

  metadata {
    sshKeys = "ubuntu:${file(var.ssh_public)}"
  }

  #Copies the script.sh file to /tmp/script.sh
  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"

    connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
	}
  }

  provisioner "remote-exec" {
	connection {
	    type = "ssh"
	    user = "ubuntu"
	    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
        }

    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh",
    ]
  }
}
