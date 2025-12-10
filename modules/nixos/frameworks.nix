{
  pkgs,
  pkgs-unstable,
  config,
  lib,
  ...
}:
let
  cfg = config.modules.nixos.frameworks;
in
{

  options.modules.nixos.frameworks = {
    qt = lib.mkOption {
      default = true;
      type = lib.types.bool;
    };
    gtk = lib.mkOption {
      default = true;
      type = lib.types.bool;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.qt {
      security.polkit.enable = true;
      xdg.portal.extraPortals = with pkgs; [
        kdePackages.xdg-desktop-portal-kde
      ];

      environment.systemPackages = with pkgs; [
        kdePackages.kio
        kdePackages.kio-fuse
        kdePackages.kio-admin
        kdePackages.kio-extras

        kdePackages.qtwayland
        libsForQt5.qt5.qtwayland

        libsForQt5.breeze-qt5
        kdePackages.breeze
        kdePackages.breeze-icons
      ];

      qt.enable = true;
      qt.platformTheme = "qt5ct";
    })
    (lib.mkIf cfg.gtk {
      security.polkit.enable = true;
      programs.dconf.enable = true;
      # Application for managing encryption keys and passwords in the GnomeKeyring
      programs.seahorse.enable = true;
      xdg.portal.extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome # for screencasting etc.
      ];
      services.gnome.gnome-keyring.enable = true;

      environment.systemPackages = with pkgs; [
        networkmanagerapplet

        adw-gtk3
      ];

      #gtk.enable = true;
      #gtk.iconTheme = {
      #  package = pkgs.adwaita-icon-theme;
      #  name = "Adwaita";
      #};
      #gtk.cursorTheme = {
      #  package = pkgs.vanilla-dmz;
      #  name = "Vanilla-DMZ";
      #  size = 16;
      #};
    })
  ];
}
