## Demo of using Nix + Bazel for a tree-sitter project

Using Nix works. If you have support for [Nix flakes](https://nixos.wiki/wiki/Flakes#Installing_flakes) turned on and direnv installed:

```
direnv allow
bazel test //tree-sitter-nbts:check-generated
```

### Issues

Using Bazel with sandboxing doesn't work.
(This requires [installing tree-sitter](https://github.com/tree-sitter/tree-sitter/releases) globally.)

```
$ bazel test --test_output=errors --verbose_failures --sandbox_debug //tree-sitter-nbts:check-generated

// bunch of stuff

+ tree-sitter generate
Operation not permitted (os error 1)
================================================================================
```

There is no reproduction command being printed,
unlike what is written in the [Bazel docs](https://bazel.build/docs/sandboxing).
