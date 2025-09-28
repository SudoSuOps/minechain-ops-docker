# MineChain Ops Docker — Terminal Ops Guide

**Repository:** `minechain-ops-docker`

**Purpose:** Build, run, and manage NVIDIA GPU + Rigel miner Docker images with reproducible workflows.

## Upstream References

- NVIDIA CUDA Installation Guide (Linux): <https://docs.nvidia.com/cuda/cuda-installation-guide-linux/>
- NVIDIA Container Toolkit: <https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html>
- NVIDIA GPU Operator: <https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/getting-started.html>
- Rigel Miner Releases: <https://github.com/rigelminer/rigel/releases>
- TensorRT Developer Guide: <https://docs.nvidia.com/deeplearning/tensorrt/developer-guide/index.html>

## Workflow (Terminal)

```bash
# Clone repository
git clone git@github.com:SudoSuOps/minechain-ops-docker.git
cd minechain-ops-docker

# Build all images locally
./scripts/build.sh

# Test containers (basic smoke)
./scripts/test.sh

# Push to GHCR (requires login)
docker login ghcr.io -u <GH_USER> -p <TOKEN>
./scripts/push.sh

# Run miner container with config volume
docker run --rm --gpus all \
  -v $(pwd)/configs:/configs \
  ghcr.io/sudosuops/minechain-ops-docker:miner-rigel-latest \
  -c /configs/rigel_rvn.json

# Execute TensorRT benchmark matrix
docker run --rm --gpus all \
  ghcr.io/sudosuops/minechain-ops-docker:trt-bench-latest

# Launch miner compose bundle
docker compose -f compose/miner-compose.yml up -d

# Launch monitoring bundle (Prometheus + DCGM + Grafana)
docker compose -f compose/monitoring-compose.yml up -d

# Verify GPU visibility
docker run --rm --gpus all nvidia/cuda:12.4.1-base-ubuntu22.04 nvidia-smi
```

## CI/CD

GitHub Actions (`.github/workflows/build-docker.yml`) builds/pushes images on commits to `main` and exposes tags `:<image>-latest`.

## Notes

- Ensure NVIDIA Container Toolkit is configured (`nvidia-ctk runtime configure`).
- Use MIG/CDI settings from `nvidia-gpu-ops` repo if targeting multi-instance GPUs.
