# Official Ubuntu base image
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install essential build dependecies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    unzip \
    wget \
    software-properties-common \
    ripgrep \
    fd-find \
    python3 \
    python3-pip \
    nodejs \
    npm \
    python3-venv \
    sudo \
    tar \
    && rm -rf /var/lib/apt/lists/*

# Setup Neovim
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
#RUN sudo rm -rf /opt/nvim
#RUN tar -C /opt -xzf nvim-linux-x86_64.tar.gz
#RUN mkdir /usr/bin/nvim
RUN tar -C /usr/bin -xzf nvim-linux-x86_64.tar.gz

# ENV PATH="$PATH:/opt/nvim-linux-x86_64/bin"
ENV PATH="$PATH:/usr/bin/nvim-linux-x86_64/bin"


# Create a user with sudo access
# RUN useradd -m -s /bin/bash -g root -G sudo devuser
# RUN useradd -m -s /bin/basd devuser
# RUN echo 'devuser' ALL=ALL NOPASSWORD:ALL >> /etc/sudoers

# Setup up user environment
# USER devuser
#WORKDIR /home/devuser/workspace
WORKDIR /root/.config/nvim


# Ensure appropriate permissions for home directory
# RUN mkdir -p /home/devuser/.config/nvim
#RUN chown -R devuser:root /home/devuser

# Set up python virtual environment

RUN python3 -m venv /home/devuser/python/venv
ENV PATH="/home/devuser/python/venv/venv/bin:$PATH"

# Install Python development tools
RUN pip install \
    black \
    flake8 \
    isort \
    mypy \
    pytest \
    django \
    djangorestframework

# Set up Neovim plugin manager (Lazy.nvim)
RUN git clone https://github.com/folke/lazy.nvim.git \
    ~/.local/share/nvim/lazy/lazy.nvim

# Set working directory
# WORKDIR /workspace
WORKDIR /root/.config/nvim

# Default command
# CMD ["nvim"]

