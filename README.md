# Bazel Rust Cross-Compilation Example

Building binaries for bare metal x86 using Bazel/Rust.

## Rough Overview

This basically gets you as far as
[Chapter 2](https://os.phil-opp.com/minimal-rust-kernel/) of Philipp Oppermann's
*Writing an OS in Rust*.

The Rust binary in question is an extremely minimal `no_std` executable. It
starts up, and enters an infinite loop. Note that what you can do at that point
is somewhat limited--there's no allocation or anything, since the
[`alloc`](https://docs.rust-embedded.org/book/collections/) crate isn't ported.

## How it Works

Most of the heavy lifting is done by
[`rules_rust`](https://github.com/bazelbuild/rules_rust). It sets up a custom
toolchain with a custom [`target.json`](./target.json). For instructions on
creating one of these yourself, see the
[*Embedonomicon*](https://docs.rust-embedded.org/embedonomicon/custom-target.html).
It then uses a transition rule to unconditionally build the target binary using
both the default and the custom toolchain.

The one interesting part is that it bootstraps libcore from source. It does
this using a raw `genrule()` -- although in theory, this could be done using
the normal `rules_rust` rules. The commands to do this were extracted from
`cargo build -Z build-std`. It additionally attempts to ensure reproducibility
in the same way as upstream `rules_rust` -- by setting
[`--remap-path-prefix`](https://github.com/bazelbuild/rules_rust/blob/89d207bae700497dc37b2a66a8f338b88c83ddaa/rust/private/rustc.bzl#L564).

## Future Enhancements

This doesn't set up any linting or other fun stuff--but most of this is also
handled by `rules_rust`. I also haven't tested how this works with remote build
execution, but in principle it should work since it only uses defined
inputs/outputs.

## Other Notes

See [duarten/rust-bazel-cross](https://github.com/duarten/rust-bazel-cross) for
an example of a more "normal" (desktop -> desktop) custom cross toolchain
setup.

## License

This code is released under the [MIT license](./LICENSE). Copy/paste it how you
will.
