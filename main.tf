resource "libvirt_pool" "VM" {
  name = var.dbname
  type = "dir"
  path = var.poolpath
}

# Defining VM Volume
resource "libvirt_volume" "VM-master-qcow2" {
  name   = "${var.dbname}-master.qcow2"
  pool   = libvirt_pool.VM.name
  source = var.remote_iso
  format = "qcow2"
}

resource "libvirt_volume" "VM-worker-qcow2" {
  name           = "${var.dbname}-worker.qcow2"
  base_volume_id = libvirt_volume.VM-master-qcow2.id
  pool           = libvirt_pool.VM.name
  size           = 10737418240
}

# Defining Virtual Machine
resource "libvirt_domain" "VM" {
  name   = "${var.dbname}-vm"
  memory = "2048"
  vcpu   = 2

  cloudinit = libvirt_cloudinit_disk.VM-init.id

  network_interface {
    network_name   = "default"
    wait_for_lease = true
  }

  disk {
    volume_id = libvirt_volume.VM-worker-qcow2.id
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "0"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }

  connection {
    type     = "ssh"
    user     = var.ssh_username
    password = var.password
    host     = libvirt_domain.VM.network_interface[0].addresses[0]
  }
}

data "template_file" "user_data" {
  template = file("config/cloud_init.yml")
}

resource "libvirt_cloudinit_disk" "VM-init" {
  name      = "VM-init.iso"
  user_data = data.template_file.user_data.rendered
  pool      = libvirt_pool.VM.name
}