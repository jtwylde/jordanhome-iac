# Ansible Playbooks

Run provision to provision all VMs
`ansible-playbook provision.yaml -i inventory/hosts.yaml --vault-password-file .vaultpw`

Run deprovision to deprovision all VMs
`ansible-playbook provision.yaml -i inventory/hosts.yaml --vault-password-file .vaultpw`
