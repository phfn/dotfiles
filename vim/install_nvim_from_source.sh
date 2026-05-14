#!/bin/bash
set -e

TAG="v0.12.0"
if (( $EUID != 0 )); then
  echo "This script must be run as root."
  exit 1
fi

work_dir=$(mktemp -d)
cd ${work_dir}
git clone https://github.com/neovim/neovim
cd neovim
git tag -d ${TAG}
git pull --tags
git checkout ${TAG}
make CMAKE_BUILD_TYPE=RelWithDebInfo

# Install as Deb if possible
if [ -f /etc/os-release ] && grep -q '^ID=debian\|ubuntu\|ID_LIKE=.*debian' /etc/os-release; then
  cd build
  cpack -G DEB
  dpkg -i nvim-linux*.deb
else
  make install
fi

