# Proxmox and Terraform: Automating VM Templates with Cloud-Init

This Terraform project automates the deployment of virtual machines (VMs) on a Proxmox hypervisor using Cloud-Init for initial configuration. It creates two Ubuntu-based VMs: a control node and a worker node, pre-configured with essential tools like Git, Python, pipx, and Ansible.

## Features

- Automated VM deployment on Proxmox
- Cloud-Init integration for initial VM setup
- Pre-installation of development tools (Git, Python, pipx, Ansible)
- Configurable VM specifications (CPU, memory, disk, network)
- Support for both control and worker node configurations

## Prerequisites

Before using this Terraform configuration, ensure you have:

1. **Proxmox VE** installed and configured
2. **Terraform** installed (version 1.0+ recommended)
3. A Proxmox API token with appropriate permissions
4. An Ubuntu cloud-init template in Proxmox (default: "VM 9002")
5. Network bridge configured (default: vmbr0)

## Configuration

### Provider Configuration

Update the `providers.tf` file with your Proxmox details:

```terraform
provider "proxmox" {
  pm_api_url          = "https://YOUR_PROXMOX_IP:8006/api2/json"
  pm_api_token_id     = "YOUR_TOKEN_ID"
  pm_api_token_secret = "YOUR_TOKEN_SECRET"
  pm_tls_insecure     = true  # Set to false for production
}
```

### Variables

Customize the deployment by modifying variables in `variables.tf`:

- `control_vm_name` / `worker_vm_name`: VM names
- `node_name`: Proxmox node name
- `template`: Cloud-init template name
- `cores`: CPU cores per VM
- `memory`: RAM in MB
- `disk_size`: VM disk size
- `storage`: Storage pool
- `bridge`: Network bridge

### Cloud-Init Configuration

Before running Terraform, you need to upload the Cloud-Init configuration file to Proxmox:

1. In the Proxmox web UI, go to **Storage** > **local** > **Content**
2. Click **Upload** and select **Snippet**
3. Upload the `snippets/install-tools.yml` file from this repository
4. The file will be available as `local:snippets/install-tools.yml`

The `snippets/install-tools.yml` file contains the Cloud-Init configuration that runs on first boot:

- Creates a user with sudo privileges
- Installs Git, Python3-pip, pipx
- Installs Ansible via pipx

## Usage

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd Proxmox-and-Terraform-Automating-VM-Templates-with-Cloud-Init
   ```

2. **Initialize Terraform:**
   ```bash
   terraform init
   ```

3. **Review the plan:**
   ```bash
   terraform plan
   ```

4. **Apply the configuration:**
   ```bash
   terraform apply
   ```

5. **Access your VMs:**
   Use the output values to connect to your newly created VMs.

## Outputs

The configuration provides the following outputs:

- `vmid`: VM ID of the control node
- `vm_name`: Name of the control node
- `vmid_worker`: VM ID of the worker node
- `vm_name_worker`: Name of the worker node

## Security Notes

- Change default passwords in `variables.tf` and `snippets/install-tools.yml`
- Update SSH keys for secure access
- Consider using Terraform variables files for sensitive data
- Set `pm_tls_insecure = false` in production environments

## Troubleshooting

- **Volume does not exist**: Ensure the `install-tools.yml` snippet is uploaded to Proxmox storage as described in the Cloud-Init Configuration section.
- **VM locked**: If a VM is locked from a previous failed operation, unlock it in the Proxmox web UI (VM > More > Unlock) or remove the VM if it's not needed. You may need to run `terraform destroy` to clean up the state and start fresh.
- Ensure your Proxmox API token has VM creation permissions
- Verify the cloud-init template exists and is properly configured
- Check network connectivity between Terraform host and Proxmox server
- Review Proxmox logs for VM creation errors

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
