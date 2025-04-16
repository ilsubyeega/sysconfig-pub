{ pkgs, ... }: {
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      plasma6Support = true;

      addons = with pkgs; [  fcitx5-gtk fcitx5-hangul ];

      # todo declare pre-defined option
    };
  };

  #environment.systemPackages = with pkgs; [ fcitx5-mozc fcitx5-gtk fcitx5-hangul ];
}
