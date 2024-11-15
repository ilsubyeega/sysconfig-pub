{ pkgs, ... }: {
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;

        enabled-extensions = [
          #"user-theme@gnome-shell-extensions.gcampax.github.com"
          "dash-to-dock@micxgx.gmail.com"
          "hidetopbar@mathieu.bidon.ca"
          "unredirect@vaina.lt"
          "Vitals@CoreCoding.com"
          "clipboard-indicator@tudmotu.com"
          "pomodoro@arun.codito.in"
        ];
      };
    };
  };

  #gtk = {
  #  enable = true;
  #  theme = {
  #    name = "adw-gtk3";
  #    package = pkgs.unstable.adw-gtk3;
  #  };
  #};


  home.packages = with pkgs.master.gnomeExtensions;
    [
      user-themes
      dash-to-dock
      hide-top-bar
      disable-unredirect-fullscreen-windows # https://gitlab.gnome.org/tuxor1337/hidetopbar/-/issues/393
      vitals
      clipboard-indicator
    ] ++ (with pkgs.unstable; [
      resources
      fractal
      easyeffects
      gnome-firmware
      gnome-pomodoro
    ]);
}
