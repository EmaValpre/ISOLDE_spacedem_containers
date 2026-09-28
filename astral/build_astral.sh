git clone https://github.com/pulp-platform/astral.git
cd astral
git checkout fc/isolde
git submodule update --init --recursive
cd ..
docker build -t astral:latest . --progress=plain 2>&1 | tee astral_build.log
