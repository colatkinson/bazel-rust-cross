load("@rules_rust//rust:toolchain.bzl", "rust_toolchain")

def i386_rust_toolchain(name, target_json, stdlib_filegroup):
    rust_toolchain_name = "%s_rust_toolchain" % name
    rust_toolchain(
        name = rust_toolchain_name,
        binary_ext = "",
        cargo = "@rust_linux_x86_64//:cargo",
        clippy_driver = "@rust_linux_x86_64//:clippy_driver_bin",
        default_edition = "2018",
        dylib_ext = ".so",
        exec_triple = "x86_64-unknown-linux-gnu",
        os = "none",
        rust_doc = "@rust_linux_x86_64//:rustdoc",
        rust_lib = stdlib_filegroup,
        rustc = "@rust_linux_x86_64//:rustc",
        rustc_lib = "@rust_linux_x86_64//:rustc_lib",
        rustc_srcs = "@rust_linux_x86_64//lib/rustlib/src:rustc_srcs",
        rustfmt = "@rust_linux_x86_64//:rustfmt_bin",
        staticlib_ext = ".a",
        stdlib_linkflags = [],
        target_json = target_json,
        visibility = ["//visibility:public"],
    )

    native.toolchain(
        name = name,
        exec_compatible_with = [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
        ],
        target_compatible_with = [
            "@platforms//cpu:i386",
            "@platforms//os:none",
        ],
        toolchain = rust_toolchain_name,
        toolchain_type = "@rules_rust//rust:toolchain",
    )

