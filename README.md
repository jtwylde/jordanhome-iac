# Ansible Playbooks

## Setup
1. Activate python venv

2. Install requirements
`pip3 install -r requirements.txt`
`ansible-galaxy install -r ansible-galaxy-requirements.yaml`

## Utility Scripts
`./runplaybook <playbook.yaml>` 
Runs the given playbook with correct args and flags

`./reprovision.sh`
Runs the deprovisioning and provisioning playbooks to quickly spin the VMs back up

## Provisioning VMs

Run provision to provision all VMs. Does the following:
* Clones the VM using debian-template template on each node
* Configures networking
* Sets hostname

`./runplaybook playbooks/provision.yaml`

Run deprovision to deprovision all VMs. Does the following:
* Removes stale SSH keys
* Stops each VM
* Removes each VM
`./runplaybook playbooks/deprovision.yaml`


## K3S

The master node defaults to the first node in the hosts list for k3s_nodes. See roles/k3s/defaults
Running the playbook will bootstrap the master node and then join the other nodes into it to form the cluster
`./runplaybook playbooks/k3s.yaml`


## Secrets
Below secrets are configured in `vault.yaml`. A `.vaultpw` file is needed in the root of the project containing the plaintext password used to encrypt the vault.

Generate new passwords as below:
```
ansible-vault encrypt_string '<secret>' \
  --vault-password-file .vaultpw \
  --name '<token_name>'
```
And copy the output into `vault.yaml`
 
### pve_api_key
The API key for the proxmox cluster

### cloudflare_api_token
The API token for cloudflare, used for DNS ACME challenges