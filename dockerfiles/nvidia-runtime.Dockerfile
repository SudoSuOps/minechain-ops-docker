FROM nvidia/cuda:13.0.0-base-ubuntu24.04

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
      python3 python3-pip python3-venv \
      libnccl2 libnccl-dev \
      libcudnn9 libcudnn9-dev \
      libnvinfer8 libnvinfer-dev && \
    python3 -m pip install --upgrade pip && \
    python3 -m pip install --no-cache-dir numpy scipy && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

WORKDIR /workspace

CMD ["/bin/bash"]
