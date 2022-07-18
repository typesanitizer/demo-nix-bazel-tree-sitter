{
  description = "Demo: Nix + Bazel + tree-sitter";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        { 
          miu = pkgs.stdenv.mkDerivation rec {
            pname = "demo-nix+bazel+tree-sitter";
            version = "0.0.0";
            nativeBuildInputs = builtins.attrValues { inherit (pkgs) cargo rustc bazel_5 tree-sitter jdk11 nodejs ; };
            # One of the Rust crates fails to build without libiconv
            buildInputs = builtins.attrValues { inherit (pkgs) libiconv ; };
            buildPhase = "tree-sitter --help && bazel --help";
            installPhase = "echo install";
            src = builtins.path { path = ./.; name = "demo-nbts"; };
          };
        }
      );

      defaultPackage = forAllSystems (system: self.packages.${system}.miu);

      devShells = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        { 
          default = pkgs.mkShell {
            nativeBuildInputs = builtins.attrValues { inherit (pkgs) cargo rustc rustfmt tree-sitter bazel_5 jdk11 nodejs ; };
            RUST_SRC_PATH = pkgs.rustPlatform.rustLibSrc;
          };
        }
      );
    };
}
