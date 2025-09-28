FROM ghcr.io/sudosuops/minechain-ops-docker:nvidia-runtime

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends wget unzip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

RUN mkdir -p sample_models/resnet50 && \
    wget -q https://github.com/onnx/models/raw/main/vision/classification/resnet/model/resnet50-v2-7.onnx -O sample_models/resnet50/ResNet50.onnx

COPY scripts/bench/trt_matrix.sh /usr/local/bin/trt-matrix
RUN chmod +x /usr/local/bin/trt-matrix

ENTRYPOINT ["/usr/local/bin/trt-matrix"]
