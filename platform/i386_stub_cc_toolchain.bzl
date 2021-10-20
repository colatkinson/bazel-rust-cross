load(
    "@bazel_tools//tools/cpp:unix_cc_toolchain_config.bzl",
    unix_cc_toolchain_config = "cc_toolchain_config",
)
load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "action_config",
    "tool",
)
load(
    "@bazel_tools//tools/build_defs/cc:action_names.bzl",
    "CPP_LINK_EXECUTABLE_ACTION_NAME",
)

def i386_stub_cc_toolchain(name):
    cc_toolchain_config_name = "%s_cc_toolchain_cfg" % name
    unix_cc_toolchain_config(
        name = cc_toolchain_config_name,
        cpu = "@platforms//cpu:i386",
        compiler = "clang",
        toolchain_identifier = "i386-bare-metal",
        host_system_name = "local",
        target_system_name = "freestanding",
        target_libc = "none",
        abi_version = "unknown",
        abi_libc_version = "unknown",
        tool_paths = {
            "llvm-cov": "/bin/false",
        },
    )

    native.filegroup(name = "empty")

    cc_toolchain_name = "%s_cc_toolchain" % name
    native.cc_toolchain(
        name = cc_toolchain_name,
        all_files = ":empty",
        compiler_files = ":empty",
        dwp_files = ":empty",
        linker_files = ":empty",
        objcopy_files = ":empty",
        strip_files = ":empty",
        supports_param_files = 0,
        toolchain_config = cc_toolchain_config_name,
    )

    native.toolchain(
        name = name,
        exec_compatible_with = [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
        ],
        target_compatible_with = [
            "@platforms//os:none",
            "@platforms//cpu:i386",
        ],
        toolchain = cc_toolchain_name,
        toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
    )

