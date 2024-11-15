{ pkgs, lib, ... }: {

  home.packages = [ (lib.setPrio 10 pkgs.google-chrome) ];

}
