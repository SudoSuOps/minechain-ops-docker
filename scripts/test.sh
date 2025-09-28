#!/usr/bin/env bash
set -euo pipefail

IMAGES=(miner-rigel nvidia-runtime pytorch trt-bench dcgm-exporter)

for IMG in "${IMAGES[@]}"; do
  echo "[*] Testing $IMG"
  docker run --rm "${IMG}:dev" --help >/dev/null || true
done
