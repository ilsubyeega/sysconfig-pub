{ pkgs, lib, ... }: {

  home.packages = [ (lib.setPrio 1 pkgs.firefox-devedition) ];

}
