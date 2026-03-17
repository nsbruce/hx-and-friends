#!/bin/sh
set -e

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install --assume-yes --no-install-recommends \
  zsh \
  curl \
  git \
  build-essential \
  clangd \
  python3 \
  python3-venv \
  shellcheck \
  npm

chsh -s /usr/bin/zsh

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
export PATH=/root/.cargo/bin:$PATH

curl --output helix.deb --location https://github.com/helix-editor/helix/releases/download/25.07.1/helix_25.7.1-1_amd64.deb
apt-get install -y ./helix.deb
rm helix.deb

curl -LsSf https://astral.sh/uv/install.sh | sh
curl -sSL https://install.python-poetry.org | python3 -

export VIRTUAL_ENV=/venv
export POETRY_NO_INTERACTION=1
export POETRY_VIRTUALENVS_CREATE=false
export PATH=$VIRTUAL_ENV/bin:/root/.local/bin:$PATH

python3 -m venv $VIRTUAL_ENV

uv pip install \
  isort \
  ruff \
  python-lsp-server \
  python-lsp-black \
  pylsp-mypy \
  ty

uv tool install commitizen

npm install --global \
  vscode-langservers-extracted \
  bash-language-server \
  dockerfile-language-server-nodejs \
  @microsoft/compose-language-service

curl -Lo texlab.tar.gz https://github.com/latex-lsp/texlab/releases/download/v5.25.1/texlab-x86_64-linux.tar.gz && tar xzf texlab.tar.gz && rm texlab.tar.gz && mv texlab /usr/local/bin/

curl -Lo /usr/local/bin/marksman https://github.com/artempyanykh/marksman/releases/download/2025-12-13/marksman-linux-x64 && chmod 755 /usr/local/bin/marksman

curl -Lo zellij.tar.gz https://github.com/zellij-org/zellij/releases/download/v0.43.1/zellij-x86_64-unknown-linux-musl.tar.gz && tar xzf zellij.tar.gz && rm zellij.tar.gz && mv zellij /usr/local/bin/

curl -Lo difft.tar.gz https://github.com/Wilfred/difftastic/releases/download/0.67.0/difft-x86_64-unknown-linux-musl.tar.gz && tar xzf difft.tar.gz && rm difft.tar.gz && mv difft /usr/local/bin/

mkdir --parents /root/.config/helix /root/.config/dprint
cp config.toml /root/.config/helix/config.toml
cp languages.toml /root/.config/helix/languages.toml
cp dprint.json /root/.config/dprint/dprint.json

cp gitconfig /root/.gitconfig

git config --global credential.helper store

# default shell
cat << 'EOF' > /etc/profile.d/hx-and-friends-shell.sh
export SHELL=/usr/bin/zsh
EOF
