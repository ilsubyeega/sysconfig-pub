{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.modules.nixos.virtualisation;
in
{
  options.modules.nixos.virtualisation = {
    virt-guest = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
    virt-manager = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
    waydroid = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
    utils = lib.mkOption {
      default = true;
      type = lib.types.bool;
    };

    containers = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.virt-guest {
      services.qemuGuest.enable = true;
      services.spice-vdagentd.enable = true;
    })
    (lib.mkIf cfg.virt-manager {
      programs.virt-manager.enable = true;
      virtualisation.libvirtd.enable = true;
      virtualisation.libvirtd.qemu.vhostUserPackages = [ pkgs.virtiofsd ];
      virtualisation.spiceUSBRedirection.enable = true;
    })
    (lib.mkIf cfg.waydroid {
      virtualisation.waydroid.enable = true;
    })
    (lib.mkIf cfg.utils {
      environment.systemPackages = with pkgs; [
        waypipe
      ];
    })
    (lib.mkIf cfg.containers {
      virtualisation.podman.enable = true;
      virtualisation.docker.enable = true;
      environment.systemPackages = with pkgs; [
        buildah
        distrobox
      ];
    })
  ];
}
