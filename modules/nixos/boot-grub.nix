{ lib, config, ... }:
let
  cfg = config.modules.nixos.boot-grub;
in
{
  options.modules.nixos.boot-grub = lib.mkOption {
    default = true;
    type = lib.types.bool;
  };
  config = lib.mkIf cfg {
    boot = {
      loader = {
        timeout = 0;
        grub = {
          enable = true;
          efiSupport = true;
          efiInstallAsRemovable = true;
          memtest86.enable = true;
          useOSProber = true;
          device = lib.mkDefault "/dev/vda";
          #forceInstall = true;
          #timeoutStyle = "hidden";

          # 4k -> 1080p -> auto
          gfxmodeBios = "3840x2160;1920x1080;auto";
        };
      };

      plymouth = {
        enable = true;
        # todo: customize plymouth
      };
    };
  };
}
