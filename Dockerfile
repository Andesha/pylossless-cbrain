# Install the base requirements for the app.
# This stage is to support development.
FROM ubuntu:latest

# Root/whole container upgrades
RUN apt update -y
RUN apt upgrade -y
RUN apt install -y build-essential python3.10 python3-pip git

# Create local user to work in
RUN useradd -U -m -s /bin/bash -d /pylossless pylossless
USER pylossless
WORKDIR /pylossless

# Install pylossless package from remote
RUN pip install git+https://github.com/Andesha/pylossless.git --user

# Update package permissions, and add to path
RUN find /pylossless -type d -print0 | xargs -0 chmod go+rx
ENV PATH=/pylossless/.local/bin:$PATH

# Copy external files
COPY bin/pylossless     /pylossless/.local/bin
COPY etc/lossless.yaml  /pylossless/lossless.yaml
# Make sure above copied files have correct ownership/group
USER root
RUN chown pylossless:pylossless /pylossless/.local/bin/pylossless /pylossless/lossless.yaml
USER pylossless

ENTRYPOINT [ "pylossless" ]