# fhsUser.nix
{ pkgs ? import <nixpkgs> {} }:
(pkgs.buildFHSUserEnv {
  name = "example-env";
  targetPkgs = pkgs: with pkgs; [
    nss
    nspr
    atk
    dbus.lib
    xorg.libX11
    xorg.libXcomposite
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libxcb
    at-spi2-atk
    # atk-bridge
    coreutils
    openssl
  ] ++ pkgs.chromium.browser.buildInputs;

  runScript = "./bisect_tmpoyap_m6w/chrome-linux/chrome";
}).env
