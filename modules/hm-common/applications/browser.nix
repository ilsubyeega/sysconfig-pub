{ pkgs, pkgs-master, ... }:
{
  home.packages = with pkgs; [
    google-chrome
    ungoogled-chromium
    (lib.setPrio 0 firefox)
    (lib.setPrio 100 firefox-devedition)
    firefoxpwa

    brave
  ];

}
