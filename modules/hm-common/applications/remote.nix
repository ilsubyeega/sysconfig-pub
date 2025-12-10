{ pkgs-unstable, ... }:
{
  home.packages = with pkgs-unstable; [
    moonlight-qt
    remmina
    parsec-bin
    wprs
    freerdp
  ];
}
