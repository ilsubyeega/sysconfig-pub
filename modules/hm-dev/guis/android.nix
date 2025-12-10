{
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.packages = with pkgs; [
    android-tools
    agi
    scrcpy
    frida-tools

    # decompilers
    pkgs-unstable.jadx
    # pkgs-unstable.recaf-launcher (lib.hiPrio jdk24) jdk23
    ghidra

    bundletool

    httptoolkit
    httptoolkit-server
  ];
}
