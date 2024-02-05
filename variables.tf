variable "vmname" {
  description = "VM vm name"
  type        = string
  default     = "mongodb_01"
}

variable "poolpath" {
  description = "The path where the libvirt pool is located"
  type        = string
  default     = "/var/kvm/VM"
}

variable "remote_iso" {
  description = "The url of the operating system image"
  type        = string
  default     = "https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img"
}

variable "mem" {
  description = "VM vm memory size"
  type        = string
  default     = "2048"
}

variable "vcpu" {
  description = "VM vm vcpus"
  type        = number
  default     = 4
}

variable "ssh_username" {
  description = "User"
  type        = string
  default     = "gastonhp1"
}

variable "password" {
  description = "Password"
  type        = string
  default     = "Pass.123!"
}

variable "build_id" {
  description = "Build ID for the VM name"
  type        = string
}

