# libvirt_VM Terraform Module

Repository for the creation of a virtual machine with Terraform and the libvirt provider in a Linux Mint host.

**Requirements**
---

+ Linux Mint + KVM2 + Libvirt + Terraform.
+ Jenkins local in the computer host.

**Usage in Jenkinsfile**
---
The idea is use this manifest inside a Jenkins Pipeline like this example:
```
terraform apply \
  -var 'vmname=$(TF_VAR_HOSTNAME)' \
  -var 'poolpath=$(TF_VAR_POOLPATH)' \
  -var 'remote_iso=$(TF_VAR_REMOTE_ISO)' \
  -var 'mem=$(TF_VAR_MEMORY)'\
  -var 'vcpu=$(TF_VAR_VCPU)' \
  -var 'ssh_username=$(TF_VAR_SSH_USERNAME)' \
  -var 'password=$(TF_VAR_PASSWORD)'
```