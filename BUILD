load("@rules_rust//rust:rust.bzl", "rust_binary")
load("@rules_rust//rust:toolchain.bzl", "rust_stdlib_filegroup")
load("//platform:i386_stub_cc_toolchain.bzl", "i386_stub_cc_toolchain")
load("//platform:i386_rust_toolchain.bzl", "i386_rust_toolchain")
load("//platform:cross.bzl", "i386_bare_metal_rust_binary")

load("//platform:libcore.bzl", "find_libcore_entrypoint")

i386_stub_cc_toolchain(name = "i386_toolchain")

find_libcore_entrypoint(
    name = "libcore_entry",
    rustc_srcs = "@rust_linux_x86_64//lib/rustlib/src:rustc_srcs",
)

genrule(
    name = "libcore",
    srcs = [
        ":libcore_entry",
        ":target.json",
        "@rust_linux_x86_64//lib/rustlib/src:rustc_srcs",
    ],
    tools = [
        "@rust_linux_x86_64//:rustc",
    ],
    outs = ["libcore.rlib"],
    cmd = """$(location @rust_linux_x86_64//:rustc) \
                --edition=2018 \
                --crate-type=lib \
                --crate-name=core \
                --target $(location :target.json) \
                --remap-path-prefix=$${PWD}=. \
                -C opt-level=2 \
                -o $@ \
                $(locations :libcore_entry)""",
    message = "Building i386 libcore",
    target_compatible_with = [
        "@platforms//os:none",
        "@platforms//cpu:i386",
    ],
    tags = ["manual"],
)

genrule(
    name = "compiler_builtins",
    srcs = [
        ":target.json",
        ":libcore.rlib",
        "@compiler_builtins//:srcs",
        "@compiler_builtins//:lib",
    ],
    tools = [
        "@rust_linux_x86_64//:rustc",
    ],
    outs = ["libcompiler_builtins.rlib"],
    cmd = """$(location @rust_linux_x86_64//:rustc) \
                --cfg 'feature="compiler-builtins"' \
                --cfg 'feature="core"' \
                --cfg 'feature="default"' \
                --cfg 'feature="mem"' \
                --cfg 'feature="rustc-dep-of-std"' \
                --cfg 'feature="unstable"' \
                -Z force-unstable-if-unmarked \
                --crate-type=lib \
                --crate-name=compiler_builtins \
                --target $(location :target.json) \
                --extern core=$(location libcore.rlib) \
                --allow unstable_name_collisions \
                --remap-path-prefix=$${PWD}=. \
                -C opt-level=2 \
                -o $@ \
                $(locations @compiler_builtins//:lib)""",
    message = "Building i386 libcompiler_builtins",
    target_compatible_with = [
        "@platforms//os:none",
        "@platforms//cpu:i386",
    ],
    tags = ["manual"],
)

rust_stdlib_filegroup(
    name = "nostd",
    srcs = [
        ":libcore.rlib",
        ":libcompiler_builtins.rlib",
    ],
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

i386_bare_metal_rust_binary(
    name = "main_i386",
    src_binary = ":main",
)
