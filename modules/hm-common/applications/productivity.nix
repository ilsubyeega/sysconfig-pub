{ pkgs, ... }:
{
  home.packages = with pkgs; [
    anki
    gnome-pomodoro
    libreoffice-fresh
    hunspell
  ];
}
