FROM nvidia/cuda:12.8.0-devel-ubuntu24.04
ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/home/dev 

ARG GIT_USER_NAME
ARG GIT_USER_EMAIL
ARG GIT_TOKEN

COPY policy-rc.d /usr/sbin/policy-rc.d
RUN chmod +x /usr/sbin/policy-rc.d

RUN apt-get update && apt-get upgrade -y

RUN apt-get update && \
    apt-get install -y \
      openssh-server \
      linux-tools-generic \
      sudo \
      curl \
      ca-certificates \
      software-properties-common \
      lsb-release \
      tzdata \
      file \
      nano \
      gnupg \
      wget && \
    rm -rf /var/lib/apt/lists/*

ENV TZ=Europe/Berlin
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

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
      gdb \
      valgrind \
      htop \
      btop \
      neofetch \
      luajit \
      nodejs \
      npm \
      python3 \
      python3-pip \
      python3-venv && \
    rm -rf /var/lib/apt/lists/*

USER dev
WORKDIR /home/dev

RUN git config --global user.name  "${GIT_USER_NAME}" && \
    git config --global user.email "${GIT_USER_EMAIL}" && \
    git config --global credential.helper store && \
    git config --global credential.useHttpPath true && \
    printf "https://%s:%s@github.com\n" \
        "${GIT_USER_NAME}" "${GIT_TOKEN}" >  /home/dev/.git-credentials && \
    chmod 600 /home/dev/.git-credentials
RUN git config --global --unset credential.useHttpPath
USER root

RUN mkdir -p /home/dev/workspace && chown -R dev:dev /home/dev/workspace
RUN mkdir -p /home/dev/tools && chown -R dev:dev /home/dev/tools
RUN mkdir -p /home/dev/scratch && chown -R dev:dev /home/dev/scratch

RUN wget -O - https://apt.llvm.org/llvm.sh | bash && \
    apt-get update && \
    apt-get install -y clang lld && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/dev/.ssh && \
    chown -R dev:dev /home/dev/.ssh

USER dev
WORKDIR /home/dev

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    . "$HOME/.cargo/env" && \
    cargo install loc hyperfine

RUN mkdir -p ~/.npm-global && \
    npm config set prefix "$HOME/.npm-global" && \
    echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.bashrc

USER root

RUN apt-get update && apt-get install -y fish && rm -rf /var/lib/apt/lists/*
RUN chsh -s /usr/bin/fish dev
RUN curl -fsSL https://starship.rs/install.sh | sh -s -- --yes
RUN mkdir -p /home/dev/.config/fish && \
    echo 'starship init fish | source' >> /home/dev/.config/fish/config.fish && \
    chown -R dev:dev /home/dev/.config
ENV CARGO_HOME=/home/dev/.cargo \
    RUSTUP_HOME=/home/dev/.rustup \
    PATH=$CARGO_HOME/bin:$PATH

COPY logo.txt /etc/motd
COPY logo.txt /etc/ssh/banner.txt
RUN sed -i 's@#Banner none@Banner /etc/ssh/banner.txt@' /etc/ssh/sshd_config

EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]