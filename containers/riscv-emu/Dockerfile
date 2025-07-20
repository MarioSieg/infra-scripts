FROM ubuntu:20.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      qemu-system-misc \
      opensbi \
      u-boot-qemu \
      qemu-utils \
      cloud-image-utils \
      wget \
      xz-utils \
    && mkdir /qemu

WORKDIR /qemu

RUN wget https://cdimage.ubuntu.com/releases/24.04/release/ubuntu-24.04.2-preinstalled-server-riscv64.img.xz \
 && xz -dk ubuntu-24.04.2-preinstalled-server-riscv64.img.xz \
 && mv ubuntu-24.04.2-preinstalled-server-riscv64.img ubuntu.img

RUN printf "Instance-ID: riscv\nLocal-Hostname: riscv\n" > meta-data \
 && cat > user-data << 'EOF'
password: ubuntu
chpasswd: { expire: False }
ssh_pwauth: True
EOF
RUN cloud-localds seed.img user-data meta-data

EXPOSE 2222

CMD [ \
  "qemu-system-riscv64", \
  "-machine", "virt", \
  "-nographic", \
  "-m", "8192", \
  "-smp", "8", \
  "-bios", "/usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.elf", \
  "-kernel", "/usr/lib/u-boot/qemu-riscv64_smode/uboot.elf", \
  "-device", "virtio-net-device,netdev=eth0", \
  "-netdev", "user,id=eth0,hostfwd=tcp::2222-:22", \
  "-drive", "file=/qemu/ubuntu.img,format=raw,if=virtio", \
  "-drive", "file=/qemu/seed.img,format=raw,if=virtio" \
]