# sshcode

**sshcode** is a macOS Terminal plugin that streamlines remote SSH access with VS Code. It automates the process of adding a new server entry to your SSH configuration, performs SSH key copying, launches VS Code Remote-SSH with a specified folder, and then connects via SSH—all from your terminal.

## Overview

The `sshcode` function does the following:

- Checks if the server is already defined in your SSH config (`~/.ssh/config`).
- If not, it prompts you for the SSH username and IP address, then appends a new configuration block.
- Runs `ssh-copy-id` with options to bypass known_hosts issues, so your SSH key is installed on the remote server.
- Launches VS Code with Remote-SSH for the given folder.
- Connects you via SSH to the remote server.

## Installation

### 1. Install the VS Code CLI

Make sure you have the VS Code CLI installed in your PATH:

- Open VS Code.
- Press `Cmd+Shift+P` to open the command palette.
- Select **Shell Command: Install 'code' command in PATH**.

### 2. Add the sshcode Function

You can either copy the function into your shell configuration file (e.g., `~/.zshrc` or `~/.bashrc`) or use the provided repository.

#### Option A: Manual Installation

Copy the `sshcode` function from the `sshcode.sh` file into your shell configuration file and then reload it:

```sh
source ~/.zshrc
```

#### Option B: Automatic Installation

You can install and activate `sshcode` with a single command. This command will clone the repository, change into its directory, and add a source command to your shell configuration:

```sh
git clone https://github.com/Delikal/sshcode.git && cd sshcode && echo "source \$(pwd)/sshcode.sh" >> ~/.zshrc && source ~/.zshrc
```

This command:

- Clones the repository from GitHub.
- Changes into the cloned directory.
- Appends a line to your ~/.zshrc to source the sshcode.sh script.
- Reloads your shell configuration.

## Usage

Run the `sshcode` command in your terminal:

```sh
sshcode <server> [folder path]
```

- If the server is not found in your SSH config, you will be prompted to enter the SSH username and IP address.
- The function will add the new server to your ~/.ssh/config and perform an ssh-copy-id to install your key.
- VS Code Remote-SSH will launch with the specified folder, and an SSH session will be started.

Features

- Automatic SSH Config Update: Prompts for and adds a new server entry if one doesn’t exist.
- SSH Key Copying: Automatically runs ssh-copy-id with options to ignore known_hosts issues.
- VS Code Integration: Launches VS Code Remote-SSH with the given folder.
- Seamless SSH Connection: Connects to the remote server via SSH after launching VS Code.

Requirements

- Operating System: macOS
- VS Code: Must be installed along with its CLI command (code) in your PATH.
- SSH Tools: ssh and ssh-copy-id should be installed and configured.

License

This project is licensed under the MIT License.
