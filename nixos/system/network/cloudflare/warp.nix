{ super, lib, pkgs, ... }:
let
  # the module is not on stable branch, so lets load directly at this time.
  warp-package =
    "${super.inputs.nixpkgs-master}/nixos/modules/services/networking/cloudflare-warp.nix";
in {
  imports = [ warp-package ];
  environment.systemPackages = [ pkgs.wgcf ];

  # use native wireguard settings, maybe?
  # the demon is bloated.
  services.cloudflare-warp.enable = true;
  systemd.services.cloudflare-warp.enable = lib.mkForce false;

  # disable warp-taskbar, this is buggy that gnome freezes.
  systemd.services.warp-taskbar.enable = false;
  systemd.user.services.warp-taskbar.enable = false;

}
