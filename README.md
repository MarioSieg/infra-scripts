# Connect to the dev container

1. Generate an SSH key
`ssh-keygen -t ed25519 -C "mario@Mac" -f ~/.ssh/id_ed25519 -N ""`

2. Copy the public key to the dev container
`scp ~/.ssh/id_ed25519.pub <USR>@<IP>:~/neos-scripts/id_ed25519.pub`

`ssh -i ~/.ssh/id_ed25519 -p <PORT> dev@<IP>`