load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_rust",
    sha256 = "531bdd470728b61ce41cf7604dc4f9a115983e455d46ac1d0c1632f613ab9fc3",
    strip_prefix = "rules_rust-d8238877c0e552639d3e057aadd6bfcf37592408",
    urls = [
        # `main` branch as of 2021-08-23
        "https://github.com/bazelbuild/rules_rust/archive/d8238877c0e552639d3e057aadd6bfcf37592408.tar.gz",
    ],
)

load("@rules_rust//rust:repositories.bzl", "rust_repositories", "rust_repository_set")

rust_repositories(
    version="nightly",
    iso_date="2021-10-11",
    include_rustc_srcs = True,
    sha256s = {
        "2021-10-11/rust-src-nightly": "d4aa52e1f7f99c08f03a3a567aa71b06e36008dd8da44ab8f097401e50b9b212",
        "2021-10-11/rust-nightly-x86_64-unknown-linux-gnu": "1561ee6072027b986aefc5ef4e38c53ff38b42234baf59bdab2492238e1cea57",
        "2021-10-11/rustfmt-nightly-x86_64-unknown-linux-gnu": "2da3436382765027cd92d049c4e06c901589e3f83cea9d6552cc33a74e7fca8f",
        "2021-10-11/llvm-tools-nightly-x86_64-unknown-linux-gnu": "8b7acd2270797172723583a26c52b5f24e3f6744ffb94c69fff81fd81b1555b1",
        "2021-10-11/rust-std-nightly-x86_64-unknown-linux-gnu": "a82425a5d6c2230f225eb97e297afba9ebc53d5748d298175893da1710a107ff",
        "2021-10-11/rust-std-nightly-wasm32-unknown-unknown": "fcf12f6bf8e899c75c1fa0ad8cf8d649ceea214b43f5e6607f42b707a653753b",
        "2021-10-11/rust-std-nightly-wasm32-wasi": "412aa0e5e9531c3e439e3b93ce7ef4bcfbd5224f4fc222c479582bb008a5859f",
    },
)

