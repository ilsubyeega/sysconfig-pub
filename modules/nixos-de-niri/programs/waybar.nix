_: {
  programs.waybar.enable = true;
  systemd.user.services.waybar.wantedBy = [ "niri.service" ];
  systemd.user.tmpfiles.rules = [
    "L /home/%u/.config/waybar - - - - /infra/personal/configs/waybar"
  ];
}
