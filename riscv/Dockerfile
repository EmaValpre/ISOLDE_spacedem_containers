FROM pulp:latest

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Etc/UTC

RUN apt-get update && apt-get install -y \
    meson expect device-tree-compiler glib-2.0-dev libzstd-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt

COPY riscv-gnu-toolchain/ /opt/riscv-gnu-toolchain/

WORKDIR /opt/riscv-gnu-toolchain/
RUN ./configure --prefix=/opt/riscv --enable-multilib && make -j$(nproc)
RUN rm -rf /opt/riscv-gnu-toolchain/
ENV RV_TOOLCHAIN=/opt/riscv/bin
WORKDIR /workspace
CMD ["/bin/bash"]
