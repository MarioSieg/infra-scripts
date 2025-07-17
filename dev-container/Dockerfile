FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive

COPY policy-rc.d /usr/sbin/policy-rc.d
RUN chmod +x /usr/sbin/policy-rc.d

RUN apt-get update && \
    apt-get install -y \
      openssh-server \
      sudo \
      curl \
      ca-certificates \
      software-properties-common \
      lsb-release \
      gnupg \
      wget && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash dev && \
    echo "dev ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/dev

RUN mkdir /var/run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config && \
    echo "PasswordAuthentication no" >>/etc/ssh/sshd_config

COPY id_ed25519.pub /home/dev/.ssh/authorized_keys

RUN chown -R dev:dev /home/dev/.ssh && \
    chmod 700 /home/dev/.ssh && \
    chmod 600 /home/dev/.ssh/authorized_keys

RUN apt-get update && \
    apt-get install -y \
      git \
      cmake \
      make \
      gcc \
      g++ \
      htop \
      btop \
      neofetch \
      luajit \
      python3 \
      python3-pip \
      python3-venv && \
    rm -rf /var/lib/apt/lists/*

RUN wget -O - https://apt.llvm.org/llvm.sh | bash && \
    apt-get update && \
    apt-get install -y clang lld && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/dev/.ssh && \
    chown -R dev:dev /home/dev/.ssh

RUN apt-get update && apt-get install -y fish && rm -rf /var/lib/apt/lists/*
RUN chsh -s /usr/bin/fish dev
RUN curl -fsSL https://starship.rs/install.sh | bash -s -- --yes
RUN mkdir -p /home/dev/.config/fish && \
    grep -qxF 'starship init fish | source' /home/dev/.config/fish/config.fish || \
    echo 'starship init fish | source' >> /home/dev/.config/fish/config.fish && \
    chown -R dev:dev /home/dev/.config

COPY logo.txt /etc/motd
COPY logo.txt /etc/ssh/banner.txt
RUN sed -i 's@#Banner none@Banner /etc/ssh/banner.txt@' /etc/ssh/sshd_config

EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]