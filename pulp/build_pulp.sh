git clone https://github.com/pulp-platform/pulp-riscv-gnu-toolchain.git
cd pulp-riscv-gnu-toolchain
git checkout v1.0.16
git submodule update --init --recursive
cd ..
docker build -t pulp:latest . --progress=plain 2>&1 | tee pulp_build.log
