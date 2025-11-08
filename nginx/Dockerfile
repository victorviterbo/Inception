# Use an official Linux distribution with development tools
FROM ng

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install essential build tools, Valgrind, and dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    g++ \
    cmake \
    make \
    valgrind \
    gdb \
    git \
    vim \
    telnet \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workspace

EXPOSE 8080
EXPOSE 8081

# Copy your project files (adjust the path as needed)
#COPY WebServ/ .
COPY .bashrc /root/.bashrc

# Optional: Set up a build script
#RUN bash /root/bashrc
