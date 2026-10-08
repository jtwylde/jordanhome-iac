# Ansible Playbooks
Some basic overview of the structure of the playbooks and how they're used in my iac setup

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

The master node defaults to the first node in the hosts list for k3s_nodes
Running the playbook will bootstrap the master node and then join the other nodes into it to form the cluster
`./runplaybook playbooks/install_3s.yaml`

These two playbooks are seperated because one needs actual k8s operations are done on localhost
`./runplaybook playbooks/configure_k3s_defaults.yaml`


## Tailscale

Currently tailscale is installed seperately, this should be consolidated into a provisioning playbook later on
`./runplaybook playbooks/tailscale.yaml`

## Jellyfin

Jellyfin is configured with one playbook which just adds all the k8s resources
`./runplaybook playbooks/jellyfin.yaml`


## Secrets
Below secrets are configured in `vault.yaml`. A `.vaultpw` file is needed in the root of the project containing the plaintext password used to encrypt the vault.

Generate new secrets as below:
`./createsecret.sh <secret-name> <secret>`

This will append the new secret into the vault.
Remove secrets by simply removing the entry from the vault

### pve_api_key
The API key for the proxmox cluster

### cloudflare_api_token
The API token for cloudflare, used for DNS ACME challenges

### tailscale_auth_key
API key for tailscale, used for automatically registering with the tailscale network