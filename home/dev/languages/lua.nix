{ pkgs, ... }: { home.packages = with pkgs.unstable; [ luajit ]; }
