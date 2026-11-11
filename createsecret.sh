file="${3:-inventory/group_vars/all/vault.yaml}"
ansible-vault encrypt_string "$2" --vault-password-file .vaultpw --name $1 >> $file