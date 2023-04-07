## Problem

A week or so ago, I hit a crash in Chromium under wayland, using the nixpkgs chromium build ([report](https://bugs.chromium.org/p/chromium/issues/detail?id=1430657)).

I was able to install an older build that doesn't have the issue, I have 3 further questions:

1. Are the official builds also affected?
2. What specific commit introduced the issue?
3. Is the issue still present in the latest dev revisions?

For the first two questions, I need to run the official builds using [bisect-builds.py](https://www.chromium.org/developers/bisect-builds-py/). I can also answer the third question this way, while answering it using nixpkgs builds would require me to build locally, which leads to other difficulties (out of space on tmpfs with my 16GB RAM, etc).

## Journey

To run these builds under nixos, I need an FHS env with the right libraries. So I set out to create one in [fhs.nix](./fhx.nix).

### How can I get grab the chromium package's runtime dependencies?

Chromium's unwrapped derivation is tucked away as `pkgs.chromium.browser`

This doesn't get them all, so I've been grinding along using `nix-locate`.

### Is there a smarter way? Also why doesn't it get them all?

dunno