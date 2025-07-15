sudo apt install qemu-system-misc opensbi u-boot-qemu qemu-utils
mkdir qemu-riscv && cd qemu-riscv
wget https://cdimage.ubuntu.com/releases/20.04.4/release/ubuntu-20.04.5-preinstalled-server-riscv64+unmatched.img.xz
xz -dk ubuntu-20.04.5-preinstalled-server-riscv64+unmatched.img.xz
ll /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.elf
ll /usr/lib/u-boot/qemu-riscv64_smode/uboot.elf
qemu-system-riscv64 -machine virt -nographic -m 2048 -smp 4 -bios /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.elf -kernel /usr/lib/u-boot/qemu-riscv64_smode/uboot.elf -device virtio-net-device,netdev=eth0 -netdev user,id=eth0 -drive file=ubuntu-20.04.5-preinstalled-server-riscv64+unmatched.img,format=raw,if=virtio
