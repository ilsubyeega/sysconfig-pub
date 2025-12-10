{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.swayosd ];
  systemd.packages = [ pkgs.swayosd ];
  services.dbus.packages = [ pkgs.swayosd ];
  services.udev.packages = [ pkgs.swayosd ];

  systemd.services.swayosd-libinput-backend.wantedBy = [ "greetd.service" ];
  systemd.user.services.swayosd = {
    description = "Volume/backlight OSD indicator";
    partOf = [ "graphical.target" ];
    after = [ "niri.service" ];

    wantedBy = [ "niri.service" ];

    unitConfig = {
      #ConditionEnvironment = "WAYLAND_DISPLAY";
      StartLimitBurst = 5;
      StartLimitIntervalSec = 10;
    };

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.swayosd}/bin/swayosd-server";
      Restart = "on-failure";
    };
  };

  # https://github.com/ErikReider/SwayOSD/blob/main/data/services/systemd/swayosd-libinput-backend.service.in

}
