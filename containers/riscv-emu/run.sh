docker run -d \
  --name riscv \
  --restart unless-stopped \
  -p 2223:2222 \
  riscv-emulator
