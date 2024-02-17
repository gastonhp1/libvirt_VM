variable "vmname" {
  description = "VM vm name"
  type        = string
  default     = "vm-ubuntu"
}

variable "poolpath" {
  description = "The path where the libvirt pool is located"
  type        = string
  default     = "/var/kvm/virtual-machines"
}

variable "remote_iso" {
  description = "The url of the operating system image"
  type        = string
  default     = "https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img"
}

variable "mem" {
  description = "node node memory size"
  type        = string
  default     = "2048"
}

variable "vcpu" {
  description = "node node vcpus"
  type        = number
  default     = 4
}

variable "ssh_username" {
  description = "User"
  type        = string
  default     = "ubuntu"
}

variable "password" {
  description = "Password"
  type        = string
  default     = "Pass.123!"
}

variable "build_id" {
  description = "Jenkins Build ID"
  type        = string
}

