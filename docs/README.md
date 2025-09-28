# MineChain Ops Docker — Operator Guide

## Overview

This repository builds and publishes container images for MineChain’s GPU workloads, ensuring consistency across miners, AI pipelines, and monitoring stacks. It’s designed for Linux terminals in datacenter settings.

## Prerequisites

- Docker 24.x with NVIDIA Container Toolkit (`nvidia-ctk`) configured
- Access to GHCR (`ghcr.io`) with appropriate tokens
- NVIDIA drivers installed on host (`nvidia-smi` succeeds)

## Image Inventory

| Image | Description | Tag |
| --- | --- | --- |
| `miner-rigel` | Rigel KawPoW miner with config volume mount | `ghcr.io/sudosuops/minechain-ops-docker:miner-rigel-latest` |
| `nvidia-runtime` | CUDA 13.0, cuDNN, TensorRT base | `...:nvidia-runtime-latest` |
| `pytorch` | PyTorch + MONAI atop runtime base | `...:pytorch-latest` |
| `trt-bench` | TensorRT benchmarking (trtexec + ONNX) | `...:trt-bench-latest` |
| `dcgm-exporter` | NVIDIA telemetry exporter | `...:dcgm-exporter-latest` |

## Terminal Flow

### Clone
```bash
git clone git@github.com:SudoSuOps/minechain-ops-docker.git
cd minechain-ops-docker
```

### Build locally
```bash
./scripts/build.sh
```

### Test locally
```bash
./scripts/test.sh
```

### Push to GHCR
```bash
docker login ghcr.io -u <GH_USER> -p <TOKEN>
./scripts/push.sh
```

### Run Rigel miner container
```bash
docker run --rm --gpus all \
  -v $(pwd)/configs:/configs \
  ghcr.io/sudosuops/minechain-ops-docker:miner-rigel-latest \
  -c /configs/rigel_rvn.json
```

### Run TensorRT benchmark container
```bash
docker run --rm --gpus all \
  ghcr.io/sudosuops/minechain-ops-docker:trt-bench-latest
```

### Docker Compose bundles
```bash
docker compose -f compose/miner-compose.yml up -d
docker compose -f compose/monitoring-compose.yml up -d
```

## CI/CD

GitHub Actions workflow `build-docker.yml` builds/pushes images on `main` commits. Uses `docker/build-push-action` with matrix across all images.

## References

- NVIDIA CUDA Installation Guide (Linux): <https://docs.nvidia.com/cuda/cuda-installation-guide-linux/>
- NVIDIA Container Toolkit Install Guide: <https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html>
- NVIDIA GPU Operator Getting Started: <https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/getting-started.html>
- NVIDIA DCGM Exporter: <https://github.com/NVIDIA/dcgm-exporter>
- TensorRT `trtexec`: <https://docs.nvidia.com/deeplearning/tensorrt/developer-guide/index.html>
- Rigel Miner Releases: <https://github.com/rigelminer/rigel/releases>
