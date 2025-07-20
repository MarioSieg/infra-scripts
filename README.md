# Neo's Scripts

* containers/dev/ - Remote machine Docker container with GPU support for CUDA, C, C++, and Python development
* containers/riscv-emu/ - RISC-V emulator docker container
* containers/pdf-tool/ - Stirling PDF docker container
* containers/runall.sh - Run all containers

# Connect to the dev container

1. Generate an SSH key
`ssh-keygen -t ed25519 -C "mario@Mac" -f ~/.ssh/id_ed25519 -N ""`

2. Copy the public key to the dev container
`scp ~/.ssh/id_ed25519.pub <USR>@<IP>:~/infra-scripts/containers/dev/id_ed25519.pub`

3. Connect to the sever and run all containers
`cd infra-scripts/containers && bash ./runall.sh`

4. Connect to the dev container
`ssh -i ~/.ssh/id_ed25519 -p 2222 dev@<IP>`