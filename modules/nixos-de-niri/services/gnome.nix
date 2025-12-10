# GNOME based services for non-GNOME desktop environment. (e.g niri)
{ pkgs, ... }:
{
  services = {
    # needed for GNOME services outside of GNOME Desktop
    dbus.packages = with pkgs; [
      gcr # GNOME Crypto services
      #gnome-settings-daemon
      libsecret
    ];

    gnome = {
      gnome-keyring.enable = true;
      gnome-user-share.enable = true;
      gnome-settings-daemon.enable = true;
      localsearch.enable = true;
    };

    # userspace virtual filesystem
    gvfs.enable = true;
  };
}
