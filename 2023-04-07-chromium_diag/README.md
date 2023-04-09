# Chromium bug investigation under NixOS

So, you've encountered a bug in a nixpkgs chromium build.

## Testing older builds in nixpkgs

You want to get a rough idea when the bug was introduced.

- Have a look through the [nixos-unstable branch history](https://github.com/NixOS/nixpkgs/commits/nixos-unstable/pkgs/applications/networking/browsers/chromium) and select a revision you think might not have the bug.

`nix run nixpkgs/GITREVISION#chromium --user-data-dir=$(mktemp -d)`

## Testing upstream chromium builds

### a single build

You want to make sure the bug is also present in upstream builds before reporting upstream.

- Look up the affected revision in `chrome://version`
- Grab the zip from https://commondatastorage.googleapis.com/chromium-browser-snapshots/index.html?prefix=Linux_x64/ (filter by revision)
- `nix run nixpkgs#steam-run ./chrome-linux/chrome --user-data-dir=$(mktemp -d) --ozone-platform-hint=auto --enable-features=WaylandWindowDecorations`

## a range of builds using bisect-build.py

- Given that you've confirmed the bug is present in the corresponding upstream build, you want to find the first build where it's introduced (or potentially the first build where it's fixed?)

`NIXPKGS_ALLOW_UNFREE=1 nix run --impure nixpkgs#steam-run ./bisect-builds.py --good 110.0.5481.177 --bad 111.0.5563.64 -a linux64 --use-local-cache -- --ozone-platform-hint=auto --enable-features=WaylandWindowDecorations`

## Other useful resources

- [Chromium Dash](https://chromiumdash.appspot.com/home) (replaces [OmahaProxy](http://omahaproxy.appspot.com/) which is EOL)



## The Current Bug

A week or so ago, I hit a crash in Chromium under wayland, using the nixpkgs chromium build ([report](https://bugs.chromium.org/p/chromium/issues/detail?id=1430657)).

To get unstuck, I was able to install an older build that doesn't have the issue.

### Journey

To run these builds under nixos, I attempted to create an FHS env with the right libraries, in [default.nix](./default.nix).

### How can I get the chromium package's runtime dependencies?

Chromium's unwrapped derivation is tucked away as `pkgs.chromium.browser`

This doesn't get them all, so I've been grinding along using `nix-locate`.

I also learned about `nix-alien`, `nix-ld`, and `nix-autobahn` from **hrnz** on Matrix, and used `nix-alien` to assist in generating the env.