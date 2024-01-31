output "ip" {
  value = libvirt_domain.VM.network_interface[0].addresses[0]
}
