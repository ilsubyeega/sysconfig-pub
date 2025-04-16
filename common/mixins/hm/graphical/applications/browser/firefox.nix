{ pkgs, pkgs-master, lib, ... }: {
  home.packages = with pkgs; [ (lib.setPrio 0 firefox) (lib.setPrio 100 pkgs-master.firefox-devedition-bin) pkgs.firefoxpwa ];
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;
    nativeMessagingHosts = [ pkgs.firefoxpwa ];
  };

  home.sessionVariables = {
    "MOZ_USE_XINPUT2" = "1";
  };
}
