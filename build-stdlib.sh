#!/bin/bash
set -euxo pipefail

tmp=$(mktemp -d)
trap 'rm -rf -- "$tmp"' EXIT

cargo="$(bazel info output_base)/external/rust_linux_x86_64/bin/cargo"
$cargo build \
    --release \
    -Zunstable-options \
    -Zbuild-std=core,compiler_builtins \
    -Zbuild-std-features=compiler-builtins-mem \
    --target target.json \
    --target-dir "$tmp"

mkdir -p stdlib
tree "$tmp"
cp "$tmp"/target/release/deps/libcore-*.rlib stdlib/libcore.rlib
cp "$tmp"/target/release/deps/libcompiler_builtins-*.rlib stdlib/libcompiler_builtins.rlib
cp "$tmp"/target/release/deps/librustc_std_workspace_core-*.rlib stdlib/librustc_std_workspace_core.rlib
