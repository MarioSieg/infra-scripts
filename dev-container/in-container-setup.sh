#!/usr/bin/env bash
set -euo pipefail

sudo apt update

# Base tools
sudo apt install -y git curl wget btop htop ca-certificates software-properties-common lsb-release neofetch cowsay cmatrix
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update && sudo apt install glow

# C, C++ tools
sudo apt install -y gcc g++ clang cmake make build-essential binutils-multiarch
bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)" # Install latest LLVM

# Python tools
sudo apt install -y python3 python3-pip python3-venv

# Lua tools
sudo apt install -y luajit luarocks

# Julia
curl -fsSL https://install.julialang.org | sh -s -- -y

# Setup fish as default shell
sudo apt install -y fish
echo $(which fish) | sudo tee -a /etc/shells
chsh -s $(which fish)

# Starship
curl -fsSL https://starship.rs/install.sh | sh -s -- --yes
fish -c "echo 'starship init fish | source' >> ~/.config/fish/config.fish"

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
. "$HOME/.cargo/env"
cargo install loc hyperfine bat delta eza # Install rust tools
