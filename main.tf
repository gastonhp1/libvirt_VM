resource "libvirt_pool" "node" {
  name = var.vmname
  type = "dir"
  path = var.poolpath
}

# Defining VM Volume
resource "libvirt_volume" "node-master-qcow2" {
  name   = "vol-${var.vmname}-master.qcow2"
  pool   = libvirt_pool.node.name
  source = var.remote_iso
  format = "qcow2"
}

resource "libvirt_volume" "node-worker-qcow2" {
  name           = "vol-${var.vmname}-worker.qcow2"
  base_volume_id = libvirt_volume.node-master-qcow2.id
  pool           = libvirt_pool.node.name
  size           = 10737418240
}

# Defining Virtual Machine
resource "libvirt_domain" "node" {
  name   = "${var.vmname}"
  memory = "2048"
  vcpu   = 2

  cloudinit = libvirt_cloudinit_disk.node-init.id

  network_interface {
    network_name   = "default"
    wait_for_lease = true
  }

  disk {
    volume_id = libvirt_volume.node-worker-qcow2.id
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
    host     = libvirt_domain.node.network_interface[0].addresses[0]
  }
}

data "template_file" "user_data" {
  template = file("config/cloud_init.yml")
}

resource "libvirt_cloudinit_disk" "node-init" {
  name      = "node-init.iso"
  user_data = data.template_file.user_data.rendered
  pool      = libvirt_pool.node.name
}