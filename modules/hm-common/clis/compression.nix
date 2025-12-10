{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lz4
  ];
}
