#!/usr/bin/env bash
set -euo pipefail

REGISTRY="ghcr.io/sudosuops/minechain-ops-docker"
IMAGES=(miner-rigel nvidia-runtime pytorch trt-bench dcgm-exporter)

for IMG in "${IMAGES[@]}"; do
  docker tag "${IMG}:dev" "${REGISTRY}:${IMG}-latest"
  docker push "${REGISTRY}:${IMG}-latest"
done
