{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = [
    (pkgs.vim_configurable.customize {
      name = "myVim";
      vimrcConfig.packages.myVimPackage = let
        vim-better-whitespace = pkgs.vimUtils.buildVimPlugin {
          name = "vim-better-whitespace";
          src = pkgs.fetchFromGitHub {
            owner = "ntpeters";
            repo = "vim-better-whitespace";
            rev = "984c8da518799a6bfb8214e1acdcfd10f5f1eed7";
            sha256 = "10l01a8xaivz6n01x6hzfx7gd0igd0wcf9ril0sllqzbq7yx2bbk";
          };
        };
      in {
        start = [ vim-better-whitespace ];
      };
    })
  ];
}