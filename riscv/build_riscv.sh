git clone https://github.com/riscv-collab/riscv-gnu-toolchain
cd riscv-gnu-toolchain
git checkout 2026.08.27
git submodule update --init --recursive
cd ..
docker build -t riscv:latest . --progress=plain 2>&1 | tee riscv_build.log
