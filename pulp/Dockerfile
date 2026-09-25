FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Etc/UTC

RUN apt-get update && apt-get install -y \
    tzdata \
    autoconf automake autotools-dev \
    curl wget ftp bzip2 liblzma-dev \
    python3.8 python3-pip python3-dev libpython3-dev \
    libmpc-dev libmpfr-dev libgmp-dev \
    gawk build-essential bison flex texinfo gperf libtool patchutils bc \
    zlib1g-dev libexpat-dev ninja-build \
    git cmake libglib2.0-dev libncurses-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN rm /usr/bin/python3 && ln -s /usr/bin/python3.8 /usr/bin/python3
RUN pip3 install tomli
COPY pulp-riscv-gnu-toolchain/ /opt/pulp-riscv-gnu-toolchain/
WORKDIR /opt/pulp-riscv-gnu-toolchain/
RUN ./configure --prefix=/opt/pulp --with-arch=rv32imc --with-cmodel=medlow --enable-multilib && make -j$(nproc)
RUN rm -rf /opt/pulp-riscv-gnu-toolchain/
ENV PULP_TOOLCHAIN=/opt/pulp/bin
WORKDIR /workspace
CMD ["/bin/bash"]