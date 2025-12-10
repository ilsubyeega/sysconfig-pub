{
  pkgs,
  pkgs-master,
  pkgs-unstable,
  config,
  lib,
  ...
}:
let
  cfg = config.modules.nixos.gaming;
in
{
  options.modules.nixos.gaming = {
    steam = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
    compat = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
    osu = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
    minecraft = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.steam {
      programs.steam.enable = true;
      programs.steam.gamescopeSession.enable = true;
      programs.steam.extraCompatPackages = with pkgs; [ proton-ge-bin ];
      programs.steam.protontricks.enable = true;
      #programs.gamemode.enable = true;
    })
    (lib.mkIf cfg.compat {
      environment.systemPackages = with pkgs; [
        bottles
        heroic
        winetricks
        dxvk
        vkd3d
      ];
    })
    (lib.mkIf cfg.osu {
      environment.systemPackages = [
        pkgs-master.osu-lazer-bin # official bin should be provided due to anticheat included.
      ];
    })
    (lib.mkIf cfg.minecraft {
      environment.systemPackages = [
        pkgs-unstable.prismlauncher
      ];
    })
  ];
}
