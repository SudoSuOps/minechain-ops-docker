FROM nvcr.io/nvidia/k8s/dcgm-exporter:3.2.6-3.1.7-ubuntu22.04

ENTRYPOINT ["/bin/dcgm-exporter"]
