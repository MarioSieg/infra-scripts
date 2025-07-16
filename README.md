# Neo's Scripts

* dev-container/ - My remote machine Docker container for C, C++, and Python development
* emu/ - RISC-V emulator runner
* setup/ - My Linux machine setup script


# Connect to the dev container

1. Generate an SSH key
`ssh-keygen -t ed25519 -C "mario@Mac" -f ~/.ssh/id_ed25519 -N ""`

2. Copy the public key to the dev container
`scp ~/.ssh/id_ed25519.pub <USR>@<IP>:~/neos-scripts/dev-container/id_ed25519.pub`

3. Connect to the sever and run dev container
`cd neos-scripts/dev-container && bash ./run.sh`

4. Connect to the dev container
`ssh -i ~/.ssh/id_ed25519 -p 2222 dev@<IP>`