{
  # All about runnables.
  # Source of truth: https://github.com/NixOS/nix/blob/master/tests/flakes/run.sh
  outputs = inputs@{ flake-parts, systems, nixpkgs, ... }:
  flake-parts.lib.mkFlake { inherit inputs; } {
    # consumer can override this, see https://github.com/nix-systems/nix-systems#consumer-usage
    systems = (import systems);
    perSystem = { config, self', inputs', pkgs, system, ... }: 
    {
      # these can be `nix run` because their program name is the same as their package name.
      # this won't work in apps though.
      packages.pa = pkgs.writeScriptBin "hello" (builtins.readFile ./cmd/hello);
      packages.pb = pkgs.writeShellApplication {
        name = "hello";
        text = ./cmd/hello;
      };
      # this one will fail tho - program name doesn't match
      packages.pc = pkgs.writeScriptBin "hellno" (builtins.readFile ./cmd/hello);
      # Apps must have a structure like this.
      # Why the distinction? 🤷
      apps = {
        aa = {
          type = "app";
          program = "${self'.packages.pa}/bin/hello";
        };
      };
    };
  };
}
