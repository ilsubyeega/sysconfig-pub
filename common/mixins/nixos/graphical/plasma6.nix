{ pkgs, pkgs-master, lib, ... }: {
  services = {
    xserver.enable = true; # do i really need this
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma6 = {
      enable = true;
      notoPackage = pkgs.noto-fonts-cjk-sans;
      # see fonts.nix for declarction
    };
  };

  environment.plasma6.excludePackages = with pkgs; [
    #kdePackages.spectacle
    kdePackages.xdg-desktop-portal-kde
  ];
  #xdg.portal.enable = lib.mkForce false;
  #xdg.portal.extraPortals = lib.mkForce [
  #  pkgs.xdg-desktop-portal-gtk
  #];

  environment.systemPackages = with pkgs.kdePackages; [
    full
    plasma-browser-integration
    ark
    kio
    kio-extras
    kio-gdrive
    keditbookmarks
    (kcalc.overrideAttrs { separateDebugInfo = true; })
    kwallet-pam
    kinfocenter
    plasma-browser-integration
    colord-kde
    kate
    krohnkite
    ksystemlog
    kcolorchooser
    kcolorpicker

    ksshaskpass
  ] ++ (with pkgs; [
    pkgs-master.application-title-bar

    flameshot # screenshot toolt

    adwaita-icon-theme
    #apirus-icon-theme
    kde-gtk-config
  ]);

  programs.ssh.askPassword = "${pkgs.kdePackages.ksshaskpass.out}/bin/ksshaskpass";
}
