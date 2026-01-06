#!/usr/bin/env bash

sudo apt update

# Base tools
sudo apt install -y git curl wget btop htop neofetch gnupg2

# C, C++ tools
sudo apt install -y gcc g++ clang cmake make build-essential binutils-multiarch
sudo bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)" # Install latest LLVM

# Nvidia drivers
sudo add-apt-repository -y ppa:graphics-drivers/ppa
sudo apt-get install -y nvidia-headless-575-open nvidia-utils-575

# Python tools
sudo apt install -y python3 python3-pip python3-venv
curl -LsSf https://astral.sh/uv/install.sh | sh

# Lua tools
sudo apt install -y luajit luarocks

# Docker
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo docker run hello-world
sudo usermod -aG docker $USER

# NVIDIA docker toolkit
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt update
export NVIDIA_CONTAINER_TOOLKIT_VERSION=1.18.1-1
sudo apt install -y \
      nvidia-container-toolkit=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
      nvidia-container-toolkit-base=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
      libnvidia-container-tools=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
      libnvidia-container1=${NVIDIA_CONTAINER_TOOLKIT_VERSION}
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker

# Setup fish as default shell
sudo apt install -y fish
echo $(which fish) | sudo tee -a /etc/shells
chsh -s $(which fish)

# Starship
curl -fsSL https://starship.rs/install.sh | sh -s -- -y
fish -c "echo 'starship init fish | source' >> ~/.config/fish/config.fish"

# Atuin
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh -s -- -y
fish -c "echo 'atuin init fish | source' >> ~/.config/fish/config.fish"

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
. "$HOME/.cargo/env"

# Tailscale
curl -fsSL https://tailscale.com/install.sh | sh -s -- -y
sudo tailscale set --ssh
sudo tailscale up --ssh

# Github CLI
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

gh auth login

