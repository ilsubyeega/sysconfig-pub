{ pkgs, lib, ... }: {

  home.packages = [ (lib.setPrio 0 pkgs.ungoogled-chromium) ];

}
