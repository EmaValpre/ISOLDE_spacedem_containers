# ISOLDE_spacedem_containers
Repository containing Dockerfiles and utility scripts to build the software environment used for compiling the AI applications developed for the ISOLDE project.

Follow the four steps below to build each container, generate the required RISC-V libraries, and generate the match-astral build/deployment environment.

Throughout the build process, it is recommended to have a stable internet connection with VPNs disabled, as there are many repositories that need to be cloned (either directly or with bender during nested build process). If the build process fails at any time, check the corresponding log file to verify which clone failed and rerun the .sh build script.

## 1 - Build the base pulp:latest container
Clone this repository and build the first container.
```bash
git clone https://github.com/EmaValpre/ISOLDE_spacedem_containers.git
cd ISOLDE_spacedem_containers/pulp
source build_pulp.sh
```
If the build fails, carefully check the log for connection timeout errors, re-run ```build_pulp.sh``` if necessary.

## 2 - Build the riscv:latest container and extract the riscv and pulp toolchain
From the ```ISOLDE_spacedem_containers``` directory go into the ```riscv``` folder, launch the build script and check for any errors in the generated log if the build fails. Note: the commands are run from the repository root.
```bash
cd riscv
source build_riscv.sh
```
Afterwards, run the container in interactive mode with:
```bash
docker run -it riscv:latest
```
Then, in another terminal, search the ID of the container and copy the pulp and riscv libraries into the ```astral``` directory. Note: the commands are run from the repository root.
```bash
docker ps   # annotate the CONTAINER ID of riscv:latest
mkdir astral/libs
docker cp <CONTAINER ID>:/opt/pulp/ ./astral/libs/pulp/
docker cp <CONTAINER ID>:/opt/riscv/ ./astral/libs/riscv/
```

## 3 - Build the astral:latest container
From the repository root, simply run the following lines. Again, if the build fails, check the log as it is almost certainly due to connection errors.
```bash
cd astral
source build_astral.sh 
```

## 4 - Build the match:latest container
Finally, build match and check for connection error in case the build fails.

```bash
cd match
source build_match.sh 
```
To generate and compile the code used in the isolde space demonstrator, navigate in ```/opt/match/examples/targets/isolde```, then run:
```bash
python compile.py
cd output && make build-host
```
This will generate the C code with the AI model's weights and graphs and then build the binary that can be deployed on the selected target.