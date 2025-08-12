FROM python:3.12-slim

# Base deps
RUN apt-get update && apt-get install -y --no-install-recommends build-essential git \
 && rm -rf /var/lib/apt/lists/*

# App user
RUN useradd -U -m -s /bin/bash -d /pylossless pylossless
USER pylossless
WORKDIR /pylossless

# Install package (user site)
RUN pip install --no-cache-dir --user git+https://github.com/Andesha/pylossless.git

# Ensure PATH finds user-site scripts
ENV PATH=/pylossless/.local/bin:$PATH
ENV PYTHONPATH=/pylossless/.local/lib/python3.12/site-packages

# Copy your entrypoint script and make it executable with LF endings
USER root
COPY bin/pylossless /pylossless/.local/bin/pylossless
RUN dos2unix /pylossless/.local/bin/pylossless 2>/dev/null || true \
 && chmod 0755 /pylossless/.local/bin/pylossless \
 && chown pylossless:pylossless /pylossless/.local/bin/pylossless
USER pylossless

# Prefer absolute path to avoid PATH resolution issues
ENTRYPOINT ["/pylossless/.local/bin/pylossless"]
