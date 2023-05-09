{
  outputs = inputs@{ nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        packages.default = pkgs.clangStdenv.mkDerivation {
          name = "way-displays";
          src = ./.;
          doCheck = true;
          checkTarget = "test";
        };
      };
    };
}
