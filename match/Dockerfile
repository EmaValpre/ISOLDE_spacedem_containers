FROM astral:latest

ARG TVM_NCORES_INSTALL=24

SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update && apt install -y software-properties-common \ 
    && rm -rf /var/lib/apt/lists/*

RUN add-apt-repository ppa:ubuntu-toolchain-r/test 
RUN apt-get update && \
    apt-get install -y gcc-11 libtinfo-dev zlib1g-dev build-essential \
    cmake libedit-dev libxml2-dev llvm-14 clang-14 llvm-14-dev unzip vim git openocd \ 
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /opt/match/ && mkdir /opt/plinio/
COPY match/ /opt/match/
COPY plinio/ /opt/plinio/
WORKDIR /opt/plinio
RUN python3 -m venv /opt/plinio/.venv && . /opt/plinio/.venv/bin/activate  && pip3 install torch==2.5.1 torchvision==0.20.1 torchaudio==2.5.1 --index-url https://download.pytorch.org/whl/cpu --verbose && pip3 install onnx==1.17 networkx numpy tdigest --verbose && python3 setup.py install
WORKDIR /opt/match
RUN . /opt/astral/.venv/bin/activate  && pip3 install -r requirements.txt --verbose && pip3 install setuptools_scm ortools numpy==1.26.4 openpyxl --verbose
RUN TVM_NCORES_INSTALL=${TVM_NCORES_INSTALL} make build_tvm
RUN . /opt/astral/.venv/bin/activate  &&  python3 setup.py install
ENV TVM_HOME="/opt/match/match-tvm"
ENV ASTRAL_PATH=/opt/astral
ENV PATH=$ASTRAL_PATH/.venv/bin:/opt/bender:$PATH
ENV PYTHONPATH=$TVM_HOME/python:/opt/match/zigzag:${PYTHONPATH}
WORKDIR /workspace
