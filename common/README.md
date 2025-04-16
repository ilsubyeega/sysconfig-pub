# sys-common
For NixOS 24.11

## todos
- categorize userspace and host(nixos) space and then separate into home-manager and nixos

## some debugging comments
```sh
nix --extra-experimental-features repl-flake repl .
```

```nix
:p common.mixins.nixos
# ^ shows full item
```