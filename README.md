# Ansible Playbooks
Some basic overview of the structure of the playbooks and how they're used in my iac setup

## Setup
1. Activate python venv
    1. `python3 -m venv venv`
    2. `source venv/bin/activate`

2. Install requirements
`pip3 install -r requirements.txt`
`ansible-galaxy install -r ansible-galaxy-requirements.yaml`

3. Copy the vault password from Bitwarden into `.vaultpw`

## Utility Scripts
`./runplaybook <playbook.yaml>` 
Runs the given playbook with correct args and flags

Most app playbooks should support an optional variable for the app state. This allows for quickly swapping between absent and present. Default is 'present'
`./runplaybook <playbook.yaml> --absent`

Other flags to the `ansible-playbook` command can be passed through freely

`./reprovision.sh`
Runs the deprovisioning and provisioning playbooks to quickly spin the VMs back up

## Provisioning VMs

Run provision to provision all VMs. Does the following:
* Clones the VM using debian-template template on each node
* Configures networking
* Sets hostname

`./runplaybook playbooks/infra/provision.yaml`

Run deprovision to deprovision all VMs. Does the following:
* Removes stale SSH keys
* Stops each VM
* Removes each VM
`./runplaybook playbooks/infra/deprovision.yaml`


## K3S

The master node defaults to the first node in the hosts list for k3s_nodes
Running the playbook will bootstrap the master node and then join the other nodes into it to form the cluster
`./runplaybook playbooks/infra/install_3s.yaml`

## Tailscale

Currently tailscale is installed seperately, this should be consolidated into a provisioning playbook later on
`./runplaybook playbooks/apps/tailscale.yaml`

## Jellyfin

Jellyfin is configured with one playbook which just adds all the k8s resources
`./runplaybook playbooks/apps/jellyfin.yaml`

## External Web Apps

External web apps (i.e web apps on the network, but not managed within the cluster) can be proxied through Traefik within the cluster. This let's us use the one VIP for everything. These are set in `inventory/group_vars/hosts` under `external`. Running the playbook will ensure all of these are created.
`./runplaybook playbooks/apps/external_web_endpoints.yaml`


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

### github_wiki
The HTTPS API Token for Gollum to clone/push to the wiki repo

### dashy_pve_api_key
The API key for Dashy to monitor the PVE cluster

### romm_auth_secret
Master secret for Romm

### romm_igdb_client_id
Client ID for IGDB API, used in Romm

### romm_igdb_client_secret
Client secret for IGDB API, used in Romm

### romm_steamgrid_api
API Token for the SteamgridDB API, used in Romm

### romm_db_root
Romm database root user password

### romm_db_user
Romm database servie user password