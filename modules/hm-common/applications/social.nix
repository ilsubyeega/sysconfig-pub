{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (pkgs.vesktop)
    fractal
    telegram-desktop
    element-desktop
  ];
}
