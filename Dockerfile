# Base image
FROM ghcr.io/openclaw/openclaw:latest

# Switch to root to install system packages
USER root

# Install build tools and utilities
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        git \
        procps \
        file && \
    rm -rf /var/lib/apt/lists/*

# Make the install non‑interactive (prevents prompts during brew)
ENV NONINTERACTIVE=1

# Install Homebrew for Linux
RUN git clone https://github.com/Homebrew/brew /home/linuxbrew/.linuxbrew/Homebrew && \
    mkdir -p /home/linuxbrew/.linuxbrew/bin && \
    ln -s /home/linuxbrew/.linuxbrew/Homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/brew

# Add Homebrew to PATH (along with the usual system paths)
ENV PATH=/home/linuxbrew/.linuxbrew/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Update Homebrew repositories
RUN brew update

# Return to the regular node user
USER node
