{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.niri.nixosModules.niri
    ./xdg.nix

    ./programs/fuzzel.nix
    ./programs/waybar.nix
    ./services/gnome.nix
    ./services/greetd.nix
    ./services/swayosd.nix
  ];
  programs.niri.enable = false; # use own implementation
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  systemd.user.tmpfiles.rules = [
    "L /home/%u/.config/niri - - - - /infra/personal/configs/niri"
    "L /home/%u/.config/gammastep - - - - /infra/personal/configs/gammastep"
    "L /home/%u/.config/hypr - - - - /infra/personal/configs/hypr"
  ];

  environment.systemPackages = with pkgs; [
    pkgs.niri-unstable

    xwayland-satellite-unstable
    wdisplays
    wlsunset

    # color temperature setup
    gammastep

    swww # background
    hyprlock

    # notification
    # fixme: make this as service.
    mako

    # clipboard
    cliphist
    wl-clipboard
  ];

  services.dbus.implementation = "broker";
  security.soteria.enable = true;

  # niri flake do itself though, but does not install by default.
  systemd.user.services = {
    xwayland-satellite = {
      wantedBy = [ "niri.service" ];
      description = "Xwayland-satellite";
      partOf = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      requisite = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.xwayland-satellite-unstable}/bin/xwayland-satellite";
        Restart = "on-failure";
      };
    };
  };
}
