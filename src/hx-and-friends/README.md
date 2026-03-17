# Helix and associated tooling (hx-and-friends)

Zsh-based development environment feature that installs:

- Zsh, Git, build-essential, clangd
- Python 3 + venv, uv, Poetry, and Python tooling (ruff, isort, pylsp, etc.)
- Rust (via rustup) and cargo utilities (texlab, zellij)
- Helix editor with custom config and markdown formatting via dprint
- Shellcheck, npm-based language servers, and dprint config

This feature can be added on top of any compatible devcontainer base image.

Example usage:

```jsonc
"features": {
  "./src": {
  }
}
```
