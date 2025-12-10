{ pkgs-master, ... }:
{
  home.packages = with pkgs-master.jetbrains; [
    idea-ultimate
    #idea-community
    pycharm-professional
    datagrip
    pkgs-master.android-studio
    clion
  ];
}
