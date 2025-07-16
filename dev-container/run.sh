#!/usr/bin/env bash
set -euo pipefail

docker build -t neo-dev-image .

docker run -d \
  --name dev-container \
  --restart=always \
  -p 2222:22 \
  -v ~/macos_id_ed25519.pub:/home/dev/.ssh/authorized_keys:ro \
  neo-dev-image
