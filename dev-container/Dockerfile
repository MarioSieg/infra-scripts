FROM ubuntu:24.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      openssh-server \
      sudo \
      curl \
      ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash dev && \
    echo "dev ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/dev

RUN mkdir /var/run/sshd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config \
    && echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

COPY in-container-setup.sh /install.sh
RUN chown dev:dev /install.sh \
    && chmod +x /install.sh \
    && su dev -c "/install.sh"

RUN mkdir -p /home/dev/.ssh \
    && chown dev:dev /home/dev/.ssh

EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]

COPY logo.txt /etc/motd
