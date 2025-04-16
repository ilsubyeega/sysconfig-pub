{ pkgs, ... }: {
  services = {
    xserver.enable = true; # do i really need this
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    xserver.desktopManager.plasma5 = {
      enable = true;
      # notoPackage = pkgs.noto-fonts-lgc-plus;
      # see fonts.nix for declartion
    };
    desktopManager.plasma6.enable = false;
  };


  environment.systemPackages = with pkgs.kdePackages; [
    full
    plasma-browser-integration
    pkgs.kdePackages.ark
    pkgs.kdePackages.kio
    pkgs.kdePackages.kio-extras
    pkgs.kdePackages.kio-gdrive
    pkgs.kdePackages.keditbookmarks
    pkgs.kdePackages.kcalc
    pkgs.kdePackages.kwallet-pam
    pkgs.kdePackages.kinfocenter
    pkgs.kdePackages.plasma-browser-integration
    pkgs.kdePackages.colord-kde
    pkgs.kdePackages.kate
    pkgs.kdePackages.krohnkite
    pkgs.kdePackages.ksystemlog
    pkgs.kdePackages.kcolorchooser
    pkgs.kdePackages.kcolorpicker 
  ] ++ (with pkgs; [
    application-title-bar
    
    adwaita-icon-theme 
    papirus-icon-theme 
    kde-gtk-config
  ]);
}
