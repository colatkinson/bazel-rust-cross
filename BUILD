load("@rules_rust//rust:rust.bzl", "rust_binary")
load("@rules_rust//rust:toolchain.bzl", "rust_stdlib_filegroup")
load("//platform:i386_stub_cc_toolchain.bzl", "i386_stub_cc_toolchain")
load("//platform:i386_rust_toolchain.bzl", "i386_rust_toolchain")

i386_stub_cc_toolchain(name = "i386_toolchain")

rust_stdlib_filegroup(
    name = "nostd",
    srcs = glob(["stdlib/*.rlib"]),
)

i386_rust_toolchain(
    name = "rust_i386_bare_metal",
    target_json = ":target.json",
    stdlib_filegroup = ":nostd",
)

rust_binary(
    name = "main",
    srcs = ["src/main.rs"],
    rustc_flags = [
        "-Cpanic=abort",
        "-Clink-arg=-nostartfiles",
        "-Ctarget-feature=+crt-static",
    ],
)
