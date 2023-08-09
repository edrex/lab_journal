{
  outputs = inputs@{self, flake-parts, nixpkgs, systems, ... }: 
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = (import systems);
      perSystem = { ... }: {
        checks = let
          inherit (nixpkgs.lib) runTests;
        in {
          runTests = runTests {
            testTrue = {
              expr = true;
              expected = true;
            };
          };
        };
      };
    };
}
