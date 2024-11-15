{
  imports = [
    ../../../overlays/default.nix
    ../../../home/environment/gnome.nix
    ../../../home/gaming/osu-lazer.nix
    ../../../home/gaming/parsec.nix
    ../../../home/gaming/moonlight.nix
    ../../../home/sync/rclone.nix
    ../../../presets/home/default.nix
    ../../../presets/home/graphical.nix
  ];

  home = {
    username = "sob";
    homeDirectory = "/home/sob";
  };
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "ilsubyeega";
    userEmail = "git@fmt.kr";
    lfs.enable = true;
  };
}
