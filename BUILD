load("@rules_rust//rust:rust.bzl", "rust_binary", "rust_library")

rust_binary(
    name = "main",
    srcs = ["src/main.rs"],
    rustc_flags = [
        "-Cpanic=abort",
        "-Clink-arg=-nostartfiles",
        "-Ctarget-feature=+crt-static",
    ],
)
