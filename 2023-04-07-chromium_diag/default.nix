{ pkgs ? import <nixpkgs> { } }:

let
  inherit (pkgs) buildFHSUserEnv;
in
buildFHSUserEnv {
  name = "chrome-fhs";
  targetPkgs = p: with p; [
    python3
    alsaLib.out
    atk.out
    at-spi2-atk.out
    cairo.out
    cups.lib
    dbus.lib
    glib.out
    gnome2.pango.out
    libxkbcommon.out
    mesa_drivers.out
    libGL.out
    libGLU.out
    # xorg_sys_opengl.out
    nspr.out
    nss.out
    xorg.libX11.out
    xorg.libXcomposite.out
    xorg.libXdamage.out
    xorg.libXfixes.out
    xorg.libXrandr.out
    xorg.libxcb.out
    xorg_sys_opengl.out
  ] ++ pkgs.chromium.browser.buildInputs;
  # runScript = "/home/edrex/src/github.com/edrex/lab_journal/2023-04-07-chromium_diag/bisect_tmpoyap_m6w/chrome-linux/chrome";
}
