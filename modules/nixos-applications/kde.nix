{ pkgs, ... }:
{
  programs.kdeconnect.enable = true;
  programs.kdeconnect.package = pkgs.kdePackages.kdeconnect-kde;
  environment.systemPackages = with pkgs; [
    # required for KDE Plasma
    kdePackages.kservice
    #kdePackages.plasma-workspace
    #kdePackages.plasma-integration

    kdePackages.dolphin
    kdePackages.ark
    # UNFREE: required to use rar archive.
    unrar
  ];

  # https://github.com/prasanthrangan/hyprdots/issues/1406#issuecomment-2338801552
  environment.etc."/xdg/menus/plasma-applications.menu".text =
    builtins.readFile "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
}
