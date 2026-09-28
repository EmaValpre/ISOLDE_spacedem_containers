FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Etc/UTC
RUN apt-get update && apt-get install -y \
    curl git wget build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev  libbz2-dev apt-utils  tk-dev libgdbm-dev uuid-dev pkg-config gdisk \
    python3 python3-distutils python3-distutils-extra python3-dev python3-pip python3-venv wget && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN mkdir bender 
WORKDIR /opt/bender
RUN curl --proto '=https' --tlsv1.2 https://pulp-platform.github.io/bender/init -sSf | sh -s -- 0.28.2

ENV BENDER=/opt/bender/bender
COPY libs/pulp/ /opt/pulp
COPY libs/riscv/ /opt/riscv
ENV PULP_TOOLCHAIN=/opt/pulp/bin
ENV RV_TOOLCHAIN=/opt/riscv/bin

ENV PATH="$RV_TOOLCHAIN:$PULP_TOOLCHAIN:$BENDER:$PATH"

COPY astral/ /opt/astral/
WORKDIR /opt/astral
RUN python3 -m venv /opt/astral/.venv && . /opt/astral/.venv/bin/activate  && pip3 install -r requirements.txt --verbose && pip3 install flatdict --verbose &&  chmod +x /opt/astral/env/env-non-iis.sh && /opt/astral/env/env-non-iis.sh

RUN  . /opt/astral/.venv/bin/activate && make isolde-checkout
RUN  . /opt/astral/.venv/bin/activate && make isolde-hw-init

RUN . /opt/astral/.venv/bin/activate && sed -i 's/-Wall -Wextra -static/-Wall -Wextra -Wno-int-conversion -Wno-implicit-function-declaration -Wno-incompatible-pointer-types -static/' cheshire/sw/sw.mk && make isolde-sw-build

RUN . /opt/astral/.venv/bin/activate && make pulpd-sw-init 

WORKDIR /workspace
CMD ["/bin/bash"]