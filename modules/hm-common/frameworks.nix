{ pkgs, ... }:
{
  gtk = {
    enable = true;
    # theme
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
    cursorTheme = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ"; # default adwaita
      size = 16;
    };
  };
  home.packages = with pkgs; [
    adw-gtk3
  ];
}
