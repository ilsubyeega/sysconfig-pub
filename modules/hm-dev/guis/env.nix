{ pkgs-unstable, ... }:
{
  home.packages = with pkgs-unstable; [
    # dbus debugging purpose
    bustle
    d-spy
  ];
}
