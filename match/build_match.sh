git clone https://github.com/eml-eda/match.git && cd match && git checkout isolde && git submodule update --init --recursive && cd ..
git clone https://github.com/eml-eda/plinio && cd plinio && git submodule update --init --recursive && cd ..
sed -i 's|cmd = \[compile_cmd\]|cmd = ["/usr/bin/clang-14"]|' ./match/match-tvm/python/tvm/contrib/cc.py

sed -i 's|/home/fpgauser/pulp_toolchain/bin/riscv32-unknown-elf-objcopy|/opt/pulp/bin/riscv32-unknown-elf-objcopy|g' ./match/examples/targets/isolde/config/Makefile
sed -i 's|/home/fpgauser/pulp_toolchain/bin/riscv32-unknown-elf-objcopy|/opt/pulp/bin/riscv32-unknown-elf-objcopy|g' ./match/examples/targets/isolde_basic/config/Makefile
sed -i 's|/home/fpgauser/pulp_toolchain/bin/riscv32-unknown-elf-objcopy|/opt/pulp/bin/riscv32-unknown-elf-objcopy|g' ./match/examples/targets/tristan/config/Makefile

sed -i 's|/home/fpgauser/pulp_toolchain/bin/riscv32-unknown-elf-objdump|/opt/pulp/bin/riscv32-unknown-elf-objdump|g' ./match/examples/targets/isolde/config/Makefile
sed -i 's|/home/fpgauser/pulp_toolchain/bin/riscv32-unknown-elf-objdump|/opt/pulp/bin/riscv32-unknown-elf-objdump|g' ./match/examples/targets/isolde_basic/config/Makefile
sed -i 's|/home/fpgauser/pulp_toolchain/bin/riscv32-unknown-elf-objdump|/opt/pulp/bin/riscv32-unknown-elf-objdump|g' ./match/examples/targets/tristan/config/Makefile


sed -i 's|CHS_SW_GCC_BINROOT = /home/fpgauser/astral_toolchain/bin|CHS_SW_GCC_BINROOT = /opt/riscv/bin|' ./match/examples/targets/isolde/config/Makefile
sed -i 's|CHS_SW_GCC_BINROOT = /home/fpgauser/astral_toolchain/bin|CHS_SW_GCC_BINROOT = /opt/riscv/bin|' ./match/examples/targets/isolde_basic/config/Makefile
sed -i 's|CHS_SW_GCC_BINROOT = /home/fpgauser/astral_toolchain/bin|CHS_SW_GCC_BINROOT = /opt/riscv/bin|' ./match/examples/targets/tristan/config/Makefile

docker build -t match:latest . --progress=plain 2>&1 | tee match_build.log