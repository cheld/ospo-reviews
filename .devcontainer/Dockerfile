FROM node:18

# Install basic development tools
RUN apt update && apt install -y less man-db sudo 

# Ensure default `node` user has access to `sudo`
ARG USERNAME=node
RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Set `DEVCONTAINER` environment variable to help with orientation
ENV DEVCONTAINER=true

# Install repolint. Copied from https://github.com/todogroup/repolinter/blob/main/Dockerfileile
ARG RUNTIME_DEPS="git libicu-dev perl python3 ruby-full locales patch ruby-dev"
ARG BUILD_DEPS="make autoconf automake python3-pip curl liblzma-dev build-essential cmake pkg-config zlib1g-dev libcurl4-openssl-dev libssl-dev libldap2-dev libidn11-dev"
RUN apt install -y $BUILD_DEPS $RUNTIME_DEPS

RUN npm install -g repolinter gitlog
RUN gem install licensee
RUN gem install github-linguist

# Install yq
RUN wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq &&\
    chmod +x /usr/bin/yq

