variable "control_vm_name" {
  type    = string
  default = "control-ubuntu-01"
}
variable "worker_vm_name" {
  type    = string
  default = "worker-ubuntu-01"
}

variable "node_name" {
  type    = string
  default = "main"
}

variable "template" {
  type    = string
  default = "VM 9002"  # <-- your new template
}

variable "cores" {
  type    = number
  default = 2
}

variable "memory" {
  type    = number
  default = 2048
}

variable "disk_size" {
  type    = string
  default = "10G"
}

variable "scsihw" {
  type    = string
  default = "virtio-scsi-pci"
}

variable "bootdisk" {
  type    = string
  default = "scsi0"
}

variable "bridge" {
  type    = string
  default = "vmbr0"
}

variable "storage" {
  type    = string
  default = "local-lvm"
}

variable "ssh_user" {
  type    = string
  default = "test"
}

variable "ssh_public_key" {
  type     = string
  default  = "key2.pub"
}

variable "cloudinit_storage" {
  type    = string
  default = "local-lvm"
}

variable "ci_user" {
  type    = string
  default = "user"
}

variable "ci_password" {
  type      = string
  sensitive = true
  default   = "1234"
}