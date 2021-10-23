def _is_included(path):
    return path.endswith("/src/library/core/src/lib.rs")


def _find_libcore_entrypoint(ctx):
    for f in ctx.attr.rustc_srcs.files.to_list():
        if f.short_path.endswith("/src/library/core/src/lib.rs"):
            return [
                DefaultInfo(files = depset([f])),
            ]

    fail("Unable to find libcore enctrypoint")


find_libcore_entrypoint = rule(
    implementation = _find_libcore_entrypoint,
    attrs = {
        "rustc_srcs": attr.label(allow_files=True),
    },
)
