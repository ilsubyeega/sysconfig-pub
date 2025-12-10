{ pkgs, ... }@inputs:
let
  dev = import ./_dev.nix inputs;
in
{
  imports = [
    ./clis/helix.nix
    ./clis/git.nix
  ];
  home.packages =
    with pkgs;
    [
      vim
      nano
      graphviz
    ]
    ++ dev.languages-all;
}
