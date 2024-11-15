{ pkgs, lib, ... }: {

  home.packages = [ (lib.setPrio 6 pkgs.firefox-beta) ];

}
