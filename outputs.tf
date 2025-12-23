output "vmid" {
  value = proxmox_vm_qemu.control-01.vmid
}
output "vm_name" {
  value = proxmox_vm_qemu.control-01.name
}
output "vmid_worker" {
  value = proxmox_vm_qemu.worker-01.vmid
}

output "vm_name_worker" {
  value = proxmox_vm_qemu.worker-01.name
}