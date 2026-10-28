playbook=$1
shift

# parse out extra flags
state_args=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --absent)
      state_args+=(-e "state=absent")
      shift
      ;;
    *)
      break
      ;;
  esac
done

ansible-playbook $playbook --vault-password-file .vaultpw "${state_args[@]}" $@