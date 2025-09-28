#!/usr/bin/env bash
set -euo pipefail

IMAGES=(miner-rigel nvidia-runtime pytorch trt-bench dcgm-exporter)

for IMG in "${IMAGES[@]}"; do
  echo "[*] Building $IMG"
  docker build -f "dockerfiles/${IMG}.Dockerfile" -t "${IMG}:dev" .
done
