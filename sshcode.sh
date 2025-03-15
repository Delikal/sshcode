function sshcode() {
  local server=$1
  local folderPath=$2

  if [[ -z "$server" ]]; then
    echo "Usage: sshcode <server> [folder path]"
    return 1
  fi

  if [[ -z "$folderPath" ]]; then
    folderPath="~"
  elif [[ "$folderPath" != /* ]]; then
    folderPath="/$folderPath"
  fi

  local ssh_config_file="$HOME/.ssh/config"
  # Create SSH config file if it doesn't exist
  if [[ ! -f "$ssh_config_file" ]]; then
    mkdir -p "$HOME/.ssh"
    touch "$ssh_config_file"
  fi

  # Check if the server entry exists in the SSH config; if not, add it.
  if ! grep -qE "^[[:space:]]*Host[[:space:]]+$server\b" "$ssh_config_file"; then
    echo -n "Enter SSH username for $server: "
    read ssh_user
    echo -n "Enter IP address for $server: "
    read ssh_ip
    {
      echo ""
      echo "Host $server"
      echo "    HostName $ssh_ip"
      echo "    User $ssh_user"
    } >> "$ssh_config_file"
    echo "Added to $ssh_config_file: $server -> $ssh_user@$ssh_ip"

    # Run ssh-copy-id with options to bypass known_hosts issues
    ssh-copy-id -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $server
  fi

  # Ensure the PATH is set properly
  export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

  # Launch VS Code Remote-SSH with the specified folder
  /usr/local/bin/code --folder-uri "vscode-remote://ssh-remote+$server$folderPath"

  # Connect via SSH
  ssh $server -t "cd $folderPath && exec \$SHELL"
}