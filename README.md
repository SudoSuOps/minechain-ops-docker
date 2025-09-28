# MineChain Ops Docker

Versioned Docker images powering MineChain GPU workloads:

- **miner-rigel** — Rigel miner with config volume support
- **nvidia-runtime** — CUDA 13.0 + cuDNN + TensorRT base (for 5090 Blackwell fleet)
- **pytorch** — PyTorch/MONAI stack on top of the runtime base
- **trt-bench** — TensorRT benchmarking image (trtexec + ONNX models)
- **dcgm-exporter** — NVIDIA telemetry exporter for Prometheus

## Usage

## Terminal Workflow

### 1. Clone & inspect

```bash
git clone git@github.com:SudoSuOps/minechain-ops-docker.git
cd minechain-ops-docker
ls dockerfiles
ls compose
```

### 2. Build all images (local)

```bash
chmod +x scripts/build.sh
./scripts/build.sh
```

### 3. Test locally

```bash
./scripts/test.sh
```

### 4. Push to GHCR

```bash
docker login ghcr.io -u <GH_USER> -p <TOKEN>
./scripts/push.sh
```

### 5. Run Rigel miner container

```bash
docker run --rm --gpus all \
  -v $(pwd)/configs:/configs \
  ghcr.io/sudosuops/minechain-ops-docker:miner-rigel-latest \
  -c /configs/rigel_rvn.json
```

### 6. TensorRT benchmark container

```bash
docker run --rm --gpus all \
  ghcr.io/sudosuops/minechain-ops-docker:trt-bench-latest
```

### 7. Compose bundles

```bash
docker compose -f compose/miner-compose.yml up -d
docker compose -f compose/monitoring-compose.yml up -d
```

## CI/CD

GitHub Actions (`.github/workflows/build-docker.yml`) builds and pushes each image to GHCR on `main` commits or manual triggers. Tags follow `:<image>-latest`.

## Repository Layout

| Path | Description |
| --- | --- |
| `dockerfiles/` | Individual Dockerfiles per workload |
| `compose/` | Docker Compose bundles for miners and monitoring |
| `scripts/` | Helper scripts for build/push/test |
| `docs/` | Extended documentation |
| `.github/workflows/` | CI pipelines |

## Source References

- NVIDIA Drivers (CUDA Installation Guide): <https://docs.nvidia.com/cuda/cuda-installation-guide-linux/>
- NVIDIA Container Toolkit Install Guide: <https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html>
- NVIDIA GPU Operator Getting Started: <https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/getting-started.html>
- NVIDIA DCGM Exporter: <https://github.com/NVIDIA/dcgm-exporter>
- TensorRT `trtexec` docs: <https://docs.nvidia.com/deeplearning/tensorrt/developer-guide/index.html>
- Rigel Miner Releases: <https://github.com/rigelminer/rigel/releases>

## Images

| Image | Source Reference | Purpose |
| --- | --- | --- |
| `miner-rigel` | [Rigel Releases](https://github.com/rigelminer/rigel/releases) | Containerized Rigel miner with GPU access and config volume |
| `nvidia-runtime` | [CUDA Install Guide](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/) | CUDA 13.0 + cuDNN + TensorRT base for AI workloads |
| `pytorch` | [CUDA + PyTorch](https://pytorch.org/get-started/locally/) | PyTorch/MONAI stack built on runtime base |
| `trt-bench` | [TensorRT `trtexec`](https://docs.nvidia.com/deeplearning/tensorrt/developer-guide/index.html) | Run ResNet50 ONNX benchmarks across FP8/FP16/INT8 |
| `dcgm-exporter` | [DCGM Exporter GitHub](https://github.com/NVIDIA/dcgm-exporter) | GPU metrics for Prometheus/Grafana |
