{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    (lib.setPrio 10 libsForQt5.breeze-qt5)
    (lib.setPrio 0 kdePackages.breeze)
    kdePackages.breeze-icons
  ];
  qt = {
    enable = true;
    style = { name = "breeze"; };
  };
}
