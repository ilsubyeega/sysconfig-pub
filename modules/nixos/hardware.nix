{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.nixos.hardware;
in
{
  options.modules.nixos.hardware = {
    common = lib.mkOption {
      default = true;
      type = lib.types.bool;
    };
    bluetooth = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.common {
      hardware.opentabletdriver = {
        enable = true;
        daemon.enable = true;

        blacklistedKernelModules = [
          "wacom"
        ];
      };

      hardware.enableAllFirmware = lib.mkDefault true;
      services.libinput.enable = true;
      services.fwupd.enable = lib.mkDefault true;
    })
    (lib.mkIf cfg.bluetooth {
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
      services.blueman.enable = true;
    })
  ];
}
