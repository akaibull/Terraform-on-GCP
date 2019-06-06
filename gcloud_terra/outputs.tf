output "instance_id" {
  value = "${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip}" //self_link is terraform interpolation for getting the data from the resource
}
