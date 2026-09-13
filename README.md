# Ansible Playbooks

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

`./runplaybook provision.yaml`

Run deprovision to deprovision all VMs. Does the following:
* Removes stale SSH keys
* Stops each VM
* Removes each VM
`./runplaybook deprovision.yaml`


## K3S

The master node defaults to the first node in the hosts list for k3s_nodes. See roles/k3s/defaults
Running the playbook will bootstrap the master node and then join the other nodes into it to form the cluster
`./runplaybook k3s.yaml`