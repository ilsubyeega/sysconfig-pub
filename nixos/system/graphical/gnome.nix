{ pkgs, ... }: {
  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    gnome.dconf-editor
    gnome.gnome-tweaks
  ];

  programs = {
    xwayland.enable = true;
    dconf.enable = true;
  };
}
