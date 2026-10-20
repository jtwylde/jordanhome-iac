playbook=$1
shift

ansible-playbook $playbook --vault-password-file .vaultpw $@