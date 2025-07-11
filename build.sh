#!/usr/bin/env bash
set -euo pipefail

# Ensure we run from the repository root
REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$REPO_ROOT/codex-rs"

# Install the Rust toolchain if necessary
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
rustup component add rustfmt
rustup component add clippy

# Build Codex
cargo build

# Launch the TUI with a sample prompt
cargo run --bin codex -- "explain this codebase to me"

# Format and lint
cargo fmt -- --config imports_granularity=Item
cargo clippy --tests

# Run the tests
cargo test
