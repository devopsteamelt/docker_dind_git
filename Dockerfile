FROM docker:24.0.7-dind

# Install dependencies
RUN apk update && \
    apk upgrade --no-cache && \
    apk add --no-cache \
    git \
    docker-compose \
    bash \
    openjdk8 \
    python3 \
    py3-pip \
    ca-certificates \
    build-base \
    libffi-dev \
    python3-dev \
    py3-setuptools \
    py3-wheel \
    py3-numpy \
    cmake \
    cython \
    yaml-dev \
    openssh-server

# Upgrade pip and create a virtual environment
RUN python3 -m venv /workspace/venv && \
    /workspace/venv/bin/pip install --upgrade pip --trusted-host pypi.org --trusted-host files.pythonhosted.org --cert /dev/null

# Print Python version for debug
RUN echo "Python version:" && /workspace/venv/bin/python --version

# Copy your code and requirements
WORKDIR /workspace
COPY requirements.txt .

# Install Python dependencies
RUN /workspace/venv/bin/pip install -r requirements.txt \
    --trusted-host pypi.org --trusted-host files.pythonhosted.org --cert /dev/null
