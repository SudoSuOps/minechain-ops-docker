FROM ghcr.io/sudosuops/minechain-ops-docker:nvidia-runtime as base

RUN python3 -m pip install --no-cache-dir torch==2.4.0+cu124 torchvision==0.19.0+cu124 torchaudio==2.4.0 --index-url https://download.pytorch.org/whl/cu124

ENV TORCH_HOME=/opt/torch
RUN mkdir -p ${TORCH_HOME}

WORKDIR /workspace

CMD ["python3"]
