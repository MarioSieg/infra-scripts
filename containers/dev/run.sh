#!/usr/bin/env bash
set -euo pipefail

read -rp "Git user name: " GIT_USER_NAME
read -rp "Git user email: " GIT_USER_EMAIL
read -rsp "GitHub Personal Access Token: " GIT_TOKEN
echo

docker build \
  --build-arg GIT_USER_NAME="$GIT_USER_NAME" \
  --build-arg GIT_USER_EMAIL="$GIT_USER_EMAIL" \
  --build-arg GIT_TOKEN="$GIT_TOKEN" \
  -t neo-dev-image .

docker run -d \
  --name dev-container \
  --restart=always \
  --gpus all \
  -p 2222:22 \
  neo-dev-image
