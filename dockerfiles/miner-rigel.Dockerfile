FROM nvidia/cuda:12.4.1-base-ubuntu22.04

ARG RIGEL_VERSION=1.22.3
ENV RIGEL_HOME=/opt/rigel \
    RIGEL_CONFIG=/configs/rigel.json

RUN apt-get update -y && \
    apt-get install -y wget ca-certificates && \
    mkdir -p ${RIGEL_HOME} && \
    wget -q https://github.com/rigelminer/rigel/releases/download/${RIGEL_VERSION}/rigel-${RIGEL_VERSION}-linux.tar.gz -O /tmp/rigel.tar.gz && \
    tar -xzf /tmp/rigel.tar.gz -C ${RIGEL_HOME} --strip-components=1 && \
    rm /tmp/rigel.tar.gz && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

VOLUME ["/configs"]

ENTRYPOINT ["/opt/rigel/rigel"]
CMD ["-c", "/configs/rigel.json"]
