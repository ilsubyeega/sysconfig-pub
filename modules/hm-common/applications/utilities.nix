{ pkgs, ... }:
{
  home.packages = with pkgs; [
    resources
    yazi # terminal file manager
    scooter # interactive file search

    file
    binsider
    binwalk
  ];
}
