{ pkgs, ... }:
/* SOME STUFF WONT WORK!!!!!!
   See https://github.com/nix-community/nix-ld?tab=readme-ov-file#my-pythonnodejsrubyinterpreter-libraries-do-not-find-the-libraries-configured-by-nix-ld
   You should set LD_LIBRARY_PATH=NIX_LD_LIBRARY_PATH to make it work.
*/
let
  ide = with pkgs.unstable.jetbrains;
    map (x: (plugins.addPlugins x [ "github-copilot" ])) [
      idea-ultimate
      idea-community
      pycharm-professional
      pycharm-community
      datagrip
      rider
      webstorm
      rust-rover
    ] ++ [ pkgs.unstable.android-studio ];

  extras = with pkgs.unstable.jetbrains; [ jcef jdk ];

in { home.packages = ide ++ extras; }
